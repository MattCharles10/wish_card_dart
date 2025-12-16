import 'package:flutter/material.dart';
import 'dart:math';
import '../../../core/constants/animations.dart';

class FloatingHearts extends StatefulWidget {
  final bool isPlaying;
  
  const FloatingHearts({super.key, required this.isPlaying});

  @override
  State<FloatingHearts> createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  final List<HeartParticle> _hearts = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    
    // Generate hearts
    for (int i = 0; i < AnimationConstants.heartCount; i++) {
      _hearts.add(HeartParticle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        speed: 0.1 + _random.nextDouble() * 0.3,
        size: 8 + _random.nextDouble() * 16,
        color: AnimationConstants.heartColors[
          _random.nextInt(AnimationConstants.heartColors.length)
        ],
        sway: _random.nextDouble() * 0.02,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _HeartPainter(
            hearts: _hearts,
            time: _controller.value,
            isPlaying: widget.isPlaying,
          ),
        );
      },
    );
  }
}

class HeartParticle {
  double x;
  double y;
  final double speed;
  final double size;
  final Color color;
  final double sway;

  HeartParticle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.color,
    required this.sway,
  });
}

class _HeartPainter extends CustomPainter {
  final List<HeartParticle> hearts;
  final double time;
  final bool isPlaying;

  _HeartPainter({
    required this.hearts,
    required this.time,
    required this.isPlaying,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isPlaying) return;
    
    final paint = Paint()..style = PaintingStyle.fill;
    
    for (final heart in hearts) {
      // Calculate position with floating motion
      final y = heart.y - heart.speed * time;
      final x = heart.x + sin(time * 2 * pi + heart.x * 10) * heart.sway;
      
      // Reset if off screen
      if (y < -0.1) {
        heart.y = 1.1;
        heart.x = _randomDouble(0.0, 1.0);
      }
      
      // Calculate opacity (fade in/out)
      final opacity = min(1.0, (1.0 - y) * 2) * min(1.0, y * 10);
      if (opacity <= 0) continue;
      
      // Set color with opacity
      paint.color = heart.color.withOpacity(opacity * 0.7);
      
      // Draw heart
      _drawHeart(
        canvas,
        Offset(x * size.width, y * size.height),
        heart.size * (0.8 + 0.4 * sin(time * 4 * pi + heart.x * 20)),
        paint,
      );
    }
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    
    // Draw heart shape
    path.moveTo(center.dx, center.dy + size * 0.3);
    
    path.cubicTo(
      center.dx - size * 0.5, center.dy + size * 0.3,
      center.dx - size * 0.5, center.dy - size * 0.2,
      center.dx, center.dy - size * 0.5,
    );
    
    path.cubicTo(
      center.dx + size * 0.5, center.dy - size * 0.2,
      center.dx + size * 0.5, center.dy + size * 0.3,
      center.dx, center.dy + size * 0.3,
    );
    
    path.close();
    canvas.drawPath(path, paint);
    
    // Add highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(center.dx - size * 0.15, center.dy - size * 0.2),
      size * 0.1,
      highlightPaint,
    );
  }

  double _randomDouble(double min, double max) {
    return min + _random.nextDouble() * (max - min);
  }

  final Random _random = Random();

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}