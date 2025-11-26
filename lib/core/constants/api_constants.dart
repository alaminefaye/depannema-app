class ApiConstants {
  // Base URL - À configurer selon votre environnement
  // IMPORTANT: Pour iOS/Android, utilisez l'adresse IP de votre machine au lieu de localhost
  // Exemple: 'http://192.168.1.100:8000/api' (remplacez par votre IP locale)
  // Pour trouver votre IP: Sur Mac/Linux: ifconfig | grep "inet " | grep -v 127.0.0.1
  // Pour production: 'https://votre-domaine.com/api'
  static const String baseUrl = 'http://localhost:8000/api';
  // Pour tester sur appareil physique iOS/Android, décommentez et remplacez par votre IP:
  // static const String baseUrl = 'http://VOTRE_IP_LOCALE:8000/api';
  
  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/reset-password';
  static const String refreshToken = '/auth/refresh';
  
  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String uploadPhoto = '/user/photo';
  
  // Client Endpoints
  static const String clientProfile = '/client/profile';
  
  // Prestataire Endpoints
  static const String prestataireProfile = '/prestataire/profile';
  static const String prestataires = '/prestataires';
  static const String prestataireDetail = '/prestataires';
  static const String searchPrestataires = '/prestataires/search';
  
  // Commande Endpoints
  static const String commandes = '/commandes';
  static const String createCommande = '/commandes';
  static const String commandeDetail = '/commandes';
  static const String updateCommandeStatus = '/commandes';
  
  // Transaction Endpoints
  static const String transactions = '/transactions';
  static const String payment = '/payment/process';
  
  // Avis Endpoints
  static const String avis = '/avis';
  static const String createAvis = '/avis';
  
  // Categorie Endpoints
  static const String categories = '/categories';
  static const String sousCategories = '/sous-categories';
  
  // Chat Endpoints
  static const String messages = '/messages';
  static const String sendMessage = '/messages';
  
  // Notification Endpoints
  static const String notifications = '/notifications';
  static const String markAsRead = '/notifications/read';
}

