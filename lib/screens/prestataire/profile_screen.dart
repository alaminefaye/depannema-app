import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../screens/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: FutureBuilder(
        future: authService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Profile Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: user?.photo != null
                          ? NetworkImage(user!.photo!)
                          : null,
                      child: user?.photo == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.name ?? 'Prestataire',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user?.email != null)
                      Text(
                        user!.email!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    if (user?.phone != null)
                      Text(
                        user!.phone!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Menu Items
              _buildMenuItem(
                context,
                icon: Icons.edit,
                title: 'Modifier le profil',
                onTap: () {
                  // TODO: Navigate to edit profile
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.work,
                title: 'Mes services',
                onTap: () {
                  // TODO: Navigate to services
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.photo_library,
                title: 'Galerie de travaux',
                onTap: () {
                  // TODO: Navigate to gallery
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.settings,
                title: 'Paramètres',
                onTap: () {
                  // TODO: Navigate to settings
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.help,
                title: 'Aide & Support',
                onTap: () {
                  // TODO: Navigate to help
                },
              ),
              const SizedBox(height: 24),
              
              // Logout Button
              ElevatedButton(
                onPressed: () async {
                  await authService.logout();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Déconnexion'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

