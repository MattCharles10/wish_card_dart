import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final AnimationController controller;
  final Color color;

  const AnimatedBackground({
    super.key,
    required this.controller,
    required this.color,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> 
    with SingleTickerProviderStateMixin {
  
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5 * _pulseAnimation.value,
              colors: [
                widget.color.withOpacity(0.1),
                const Color(0xFF1A0033),
                const Color(0xFF0A0014),
              ],
              stops: const [0.1, 0.5, 1.0],
            ),
          ),
          child: CustomPaint(
            painter: _MusicWavePainter(
              animationValue: widget.controller.value,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}

class _MusicWavePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _MusicWavePainter({
    required this.animationValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    // Draw pulsing circles
    for (int i = 0; i < 5; i++) {
      final radius = 50.0 + i * 100 + 50 * sin(animationValue * 2 * pi + i);
      final center = Offset(size.width / 2, size.height / 2);
      
      canvas.drawCircle(center, radius, paint);
    }

    // Draw music waves
    final wavePaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final waveHeight = 100.0;
    final path = Path();
    
    path.moveTo(0, size.height / 2);
    
    for (double x = 0; x < size.width; x += 5) {
      final y = size.height / 2 + 
          sin(x * 0.02 + animationValue * 4 * pi) * 
          waveHeight * (0.5 + 0.5 * sin(animationValue * pi));
      path.lineTo(x, y);
    }
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}