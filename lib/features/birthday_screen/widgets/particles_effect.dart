import 'package:flutter/material.dart';
import 'dart:math';

class ParticlesEffect extends StatefulWidget {
  final int particleCount;
  final Color color;
  
  const ParticlesEffect({
    super.key,
    this.particleCount = 50,
    required this.color,
  });

  @override
  State<ParticlesEffect> createState() => _ParticlesEffectState();
}

class _ParticlesEffectState extends State<ParticlesEffect> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    // Initialize particles
    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 2 + _random.nextDouble() * 4,
        speed: 0.1 + _random.nextDouble() * 0.3,
        color: widget.color.withOpacity(0.5 + _random.nextDouble() * 0.5),
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
          painter: _ParticlesPainter(
            particles: _particles,
            time: _controller.value,
          ),
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final Color color;
  
  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.color,
  });
}

class _ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double time;
  
  _ParticlesPainter({
    required this.particles,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    for (final particle in particles) {
      // Update position
      final y = particle.y - particle.speed * time;
      if (y < 0) {
        particle.y = 1.0;
        particle.x = Random().nextDouble();
      } else {
        particle.y = y;
      }
      
      // Draw particle
      paint.color = particle.color.withOpacity(0.7);
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size * (0.8 + 0.4 * sin(time * 2 * pi + particle.x * 10)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}