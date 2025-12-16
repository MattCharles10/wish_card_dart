import 'dart:math';
import 'package:flutter/material.dart';

class AnimationConstants {
  // Durations
  static const Duration cakeFloatDuration = Duration(seconds: 4);
  static const Duration confettiDuration = Duration(milliseconds: 1500);
  static const Duration heartDuration = Duration(milliseconds: 2000);
  static const Duration textGlowDuration = Duration(milliseconds: 1000);
  static const Duration wishTransitionDuration = Duration(milliseconds: 500);
  static const Duration musicVisualizerDuration = Duration(milliseconds: 800);
  
  // Curves
  static const Curve floatCurve = Curves.easeInOutSine;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve fadeCurve = Curves.easeInOutCubic;
  static const Curve scaleCurve = Curves.easeOutBack;
  
  // Delays
  static const Duration autoCycleDelay = Duration(seconds: 8);
  static const Duration musicStartDelay = Duration(milliseconds: 500);
  static const Duration confettiHideDelay = Duration(milliseconds: 1500);
  
  // Particle counts
  static const int confettiCount = 80;
  static const int heartCount = 15;
  static const int starCount = 30;
  
  // Animation values
  static const double cakeFloatRange = 20.0;
  static const double cakeScaleRange = 0.1;
  static const double textGlowIntensity = 0.8;
  
  // Colors for particles
  static List<Color> get confettiColors => [
    const Color(0xFFFF69C5),
    const Color(0xFF9D4EDD),
    const Color(0xFFFFD700),
    const Color(0xFF87CEEB),
    const Color(0xFFFF7F50),
    const Color(0xFF98FB98),
  ];
  
  static List<Color> get heartColors => [
    const Color(0xFFFF69C5),
    const Color(0xFFFF1493),
    const Color(0xFFFFB6C1),
    const Color(0xFFFF69C5).withOpacity(0.7),
  ];
  
  // Random particle generator
  static ParticleConfig generateConfetti(Random random) {
    return ParticleConfig(
      x: random.nextDouble(),
      y: random.nextDouble() * 0.5,
      speed: 0.5 + random.nextDouble() * 2,
      size: 5 + random.nextDouble() * 10,
      color: confettiColors[random.nextInt(confettiColors.length)],
      rotation: random.nextDouble() * pi * 2,
    );
  }
  
  static ParticleConfig generateHeart(Random random) {
    return ParticleConfig(
      x: random.nextDouble(),
      y: random.nextDouble(),
      speed: 0.2 + random.nextDouble() * 0.5,
      size: 8 + random.nextDouble() * 12,
      color: heartColors[random.nextInt(heartColors.length)],
      rotation: random.nextDouble() * pi * 0.1,
    );
  }
}

class ParticleConfig {
  final double x;
  final double y;
  final double speed;
  final double size;
  final Color color;
  final double rotation;
  
  const ParticleConfig({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.color,
    required this.rotation,
  });
}

class AnimationUtils {
  static double bounceValue(double animationValue) {
    return sin(animationValue * 2 * pi) * 0.1 + 1;
  }
  
  static double pulseValue(double animationValue) {
    return 0.5 + 0.5 * sin(animationValue * 2 * pi);
  }
  
  static Color colorPulse(Color baseColor, double animationValue) {
    final pulse = pulseValue(animationValue);
    return baseColor.withOpacity(baseColor.opacity * pulse);
  }
  
  static Offset circularMotion(double radius, double angle) {
    return Offset(
      radius * cos(angle),
      radius * sin(angle),
    );
  }
}