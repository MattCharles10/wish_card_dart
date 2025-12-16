import 'package:flutter/material.dart';
import 'dart:math';
import '../../../core/constants/animations.dart';

class ConfettiAnimation extends StatefulWidget {
  final Random random;
  final Color color;
  
  const ConfettiAnimation({
    super.key,
    required this.random,
    required this.color,
  });

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  final List<ConfettiParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
    
    // Generate confetti particles
    for (int i = 0; i < AnimationConstants.confettiCount; i++) {
      _particles.add(ConfettiParticle(
        x: widget.random.nextDouble(),
        y: widget.random.nextDouble() * 0.5,
        speed: 0.5 + widget.random.nextDouble() * 2,
        size: 5 + widget.random.nextDouble() * 15,
        color: AnimationConstants.confettiColors[
          widget.random.nextInt(AnimationConstants.confettiColors.length)
        ],
        rotation: widget.random.nextDouble() * pi * 2,
        rotationSpeed: (widget.random.nextDouble() - 0.5) * 0.2,
        shape: widget.random.nextInt(3),
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
          painter: _ConfettiPainter(
            particles: _particles,
            progress: _controller.value,
            baseColor: widget.color,
          ),
        );
      },
    );
  }
}

class ConfettiParticle {
  final double x;
  final double y;
  final double speed;
  final double size;
  final Color color;
  final double rotation;
  final double rotationSpeed;
  final int shape; // 0: rectangle, 1: circle, 2: star

  ConfettiParticle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.color,
    required this.rotation,
    required this.rotationSpeed,
    required this.shape,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;
  final Color baseColor;

  _ConfettiPainter({
    required this.particles,
    required this.progress,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    for (final particle in particles) {
      // Calculate position with gravity and wind
      final y = particle.y + particle.speed * progress;
      final x = particle.x + sin(progress * pi * 2 + particle.x * 10) * 0.1;
      
      if (y > 1.2) continue; // Particle is out of screen
      
      // Calculate opacity (fade out at the end)
      final opacity = 1.0 - min(1.0, (y - 0.8) * 5);
      if (opacity <= 0) continue;
      
      // Calculate rotation
      final rotation = particle.rotation + particle.rotationSpeed * progress * 50;
      
      canvas.save();
      
      // Translate to particle position
      canvas.translate(x * size.width, y * size.height);
      canvas.rotate(rotation);
      
      // Set color with opacity
      paint.color = particle.color.withOpacity(opacity);
      
      // Draw different shapes
      switch (particle.shape) {
        case 0: // Rectangle
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: particle.size,
              height: particle.size * 0.3,
            ),
            paint,
          );
          break;
        case 1: // Circle
          canvas.drawCircle(Offset.zero, particle.size * 0.5, paint);
          break;
        case 2: // Star
          _drawStar(canvas, paint, particle.size);
          break;
      }
      
      canvas.restore();
    }
    
    // Draw some special golden confetti
    _drawGoldenConfetti(canvas, size);
  }

  void _drawStar(Canvas canvas, Paint paint, double size) {
    final path = Path();
    final radius = size * 0.5;
    
    for (int i = 0; i < 5; i++) {
      final angle = i * 4 * pi / 5;
      final x = radius * cos(angle);
      final y = radius * sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawGoldenConfetti(Canvas canvas, Size size) {
    final goldenPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        colors: [
          const Color(0xFFFFD700),
          const Color(0xFFFFA500),
          const Color(0xFFFFD700),
        ],
      ).createShader(const Rect.fromLTWH(0, 0, 100, 100));
    
    // Draw some special golden sparkles
    for (int i = 0; i < 10; i++) {
      final x = sin(progress * pi * 2 + i) * size.width * 0.5 + size.width * 0.5;
      final y = progress * size.height + i * 20;
      
      if (y > size.height) continue;
      
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * pi * 2 + i);
      
      // Draw sparkle as a cross
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: 8,
          height: 2,
        ),
        goldenPaint,
      );
      
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: 2,
          height: 8,
        ),
        goldenPaint,
      );
      
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}