import 'dart:convert';
import '../constants/api_constants.dart';
import '../services/api_service.dart';
import '../../models/user.dart';
import '../../core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> login(String identifier, String password, {bool rememberMe = false}) async {
    try {
      final response = await _apiService.post(
        ApiConstants.login,
        {
          'identifier': identifier, // email or phone
          'password': password,
        },
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        final token = data['token'] as String;
        final user = User.fromJson(data['user'] as Map<String, dynamic>);

        await _apiService.setToken(token);
        await _saveUser(user);
        await _saveUserType(user.type);
        if (rememberMe) {
          await _saveRememberMe(true);
        }

        return {
          'success': true,
          'user': user,
          'token': token,
        };
      }

      throw Exception(response['message'] ?? 'Erreur de connexion');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String identifier, // email or phone
    required String password,
    required String passwordConfirmation,
    String? photo,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConstants.register,
        {
          'name': name,
          'identifier': identifier,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'photo': photo,
        },
      );

      if (response['success'] == true) {
        // Si l'API retourne directement le token et l'utilisateur, on les utilise
        if (response['data'] != null) {
          final data = response['data'] as Map<String, dynamic>;
          final token = data['token'] as String?;
          final user = data['user'] != null
              ? User.fromJson(data['user'] as Map<String, dynamic>)
              : null;

          if (token != null) {
            await _apiService.setToken(token);
          }
          if (user != null) {
            await _saveUser(user);
            await _saveUserType(user.type);
          }

          return {
            'success': true,
            'message': response['message'] ?? 'Inscription réussie',
            'user': user,
            'token': token,
          };
        }

        // Sinon, on fait un login automatique après l'inscription
        try {
          final loginResult = await login(identifier, password);
          return {
            'success': true,
            'message': response['message'] ?? 'Inscription réussie',
            'user': loginResult['user'],
            'token': loginResult['token'],
          };
        } catch (loginError) {
          // Si le login automatique échoue, on retourne juste le succès de l'inscription
          return {
            'success': true,
            'message': response['message'] ?? 'Inscription réussie. Veuillez vous connecter.',
          };
        }
      }

      throw Exception(response['message'] ?? 'Erreur d\'inscription');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> sendOtp(String identifier) async {
    try {
      final response = await _apiService.post(
        ApiConstants.sendOtp,
        {'identifier': identifier},
      );

      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Erreur lors de l\'envoi de l\'OTP');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String identifier, String otp) async {
    try {
      final response = await _apiService.post(
        ApiConstants.verifyOtp,
        {
          'identifier': identifier,
          'otp': otp,
        },
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        final token = data['token'] as String?;
        final user = data['user'] != null
            ? User.fromJson(data['user'] as Map<String, dynamic>)
            : null;

        if (token != null) {
          await _apiService.setToken(token);
        }
        if (user != null) {
          await _saveUser(user);
          await _saveUserType(user.type);
        }

        return {
          'success': true,
          'user': user,
          'token': token,
        };
      }

      throw Exception(response['message'] ?? 'Code OTP invalide');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> resetPassword(String identifier) async {
    try {
      final response = await _apiService.post(
        ApiConstants.resetPassword,
        {'identifier': identifier},
      );

      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Erreur lors de la réinitialisation');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post(ApiConstants.logout, null);
    } catch (e) {
      // Continue même en cas d'erreur
    } finally {
      await _apiService.clearToken();
      await _clearUserData();
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(AppConstants.userKey);
      if (userJson != null) {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return User.fromJson(userMap);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.userTypeKey);
  }

  Future<bool> isAuthenticated() async {
    final token = await _apiService.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.userKey, jsonEncode(user.toJson()));
  }

  Future<void> _saveUserType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.userTypeKey, type);
  }

  Future<void> _saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.rememberMeKey, value);
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.userKey);
    await prefs.remove(AppConstants.userTypeKey);
    await prefs.remove(AppConstants.rememberMeKey);
  }
}

