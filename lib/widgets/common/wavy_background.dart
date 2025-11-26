import 'package:flutter/material.dart';
import 'dart:math' as math;

class WavyBackground extends StatelessWidget {
  final Widget child;
  final Color topColor;
  final Color bottomColor;
  final double waveHeight;

  const WavyBackground({
    super.key,
    required this.child,
    this.topColor = const Color(0xFFFF6B6B),
    this.bottomColor = Colors.white,
    this.waveHeight = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topSectionHeight = screenHeight * (0.20 + waveHeight);
    
    return Stack(
      children: [
        // Top coral section with pattern
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: topSectionHeight + 30,
          child: ClipPath(
            clipper: WavyClipper(),
            child: Container(
              color: topColor,
              child: CustomPaint(
                painter: TopographicPatternPainter(),
              ),
            ),
          ),
        ),
        // Bottom white section
        Positioned(
          top: topSectionHeight,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: bottomColor,
            child: child,
          ),
        ),
      ],
    );
  }
}

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final waveY = size.height * 0.7; // Where wave starts
    
    // Top rectangle
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, waveY);
    
    // Simple smooth wave from right to left
    for (double i = size.width; i >= 0; i -= 1) {
      final wave = math.sin(i / 40) * 20 + math.cos(i / 70) * 10;
      final y = waveY + wave;
      path.lineTo(i, y);
    }
    
    path.lineTo(0, size.height);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class TopographicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Simple horizontal wavy lines
    for (double y = 20; y < size.height * 0.65; y += 30) {
      final path = Path();
      path.moveTo(0, y);
      
      for (double x = 0; x <= size.width; x += 2) {
        final wave = math.sin(x / 80) * 6;
        path.lineTo(x, y + wave);
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
