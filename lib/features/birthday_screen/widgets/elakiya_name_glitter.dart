import 'package:flutter/material.dart';
import 'dart:math';
import '../../../core/theme/text_theme.dart';

class ElakiyaNameGlitter extends StatefulWidget {
  const ElakiyaNameGlitter({super.key});

  @override
  State<ElakiyaNameGlitter> createState() => _ElakiyaNameGlitterState();
}

class _ElakiyaNameGlitterState extends State<ElakiyaNameGlitter> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _glitterAnimation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _glitterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
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
        return Stack(
          alignment: Alignment.center,
          children: [
            // Glow Background
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF69C5).withOpacity(0.2 * _glitterAnimation.value),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            
            // Main Name Text
            Text(
              'ELAKIYA',
              style: AppTextTheme.elakiyaNameStyle.copyWith(
                shadows: [
                  Shadow(
                    blurRadius: 20 + 10 * _glitterAnimation.value,
                    color: const Color(0xFFFF69C5),
                  ),
                  Shadow(
                    blurRadius: 40 + 20 * _glitterAnimation.value,
                    color: const Color(0xFFFFD700),
                  ),
                ],
              ),
            ),
            
            // Sparkles around the name
            ..._buildSparkles(),
            
            // Crown above the name
            Positioned(
              top: -30,
              child: Transform.rotate(
                angle: sin(_controller.value * 2 * pi) * 0.1,
                child: Icon(
                  Icons.crop,
                  color: const Color(0xFFFFD700),
                  size: 40 + 10 * sin(_controller.value * 4 * pi),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildSparkles() {
    final sparkles = <Widget>[];
    final letters = ['E', 'L', 'A', 'K', 'I', 'Y', 'A'];
    final positions = [-120, -80, -40, 0, 40, 80, 120];
    
    for (int i = 0; i < letters.length; i++) {
      final offset = sin(_controller.value * 2 * pi + i) * 10;
      
      sparkles.add(
        Positioned(
          left: positions[i].toDouble() + 150,
          top: 20 + offset,
          child: Transform.scale(
            scale: 0.8 + 0.4 * sin(_controller.value * 4 * pi + i),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.yellow.withOpacity(0.8 * _glitterAnimation.value),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  letters[i],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    
    // Additional random sparkles
    for (int i = 0; i < 15; i++) {
      final x = _random.nextDouble() * 300 - 150;
      final y = _random.nextDouble() * 100 - 50;
      final size = 4 + _random.nextDouble() * 8;
      final opacity = 0.3 + 0.7 * sin(_controller.value * 2 * pi + i);
      
      sparkles.add(
        Positioned(
          left: x + 150,
          top: y + 50,
          child: Opacity(
            opacity: opacity,
            child: Icon(
              Icons.star,
              color: const Color(0xFFFFD700),
              size: size,
            ),
          ),
        ),
      );
    }
    
    return sparkles;
  }
}