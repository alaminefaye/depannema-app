import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../screens/shared/splash_screen.dart';

class LiggeyalmaApp extends StatelessWidget {
  const LiggeyalmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liggeyalma',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

