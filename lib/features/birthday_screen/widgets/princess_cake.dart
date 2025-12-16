import 'package:flutter/material.dart';
import 'dart:math';
import '../../../core/constants/animations.dart';

class PrincessCake extends StatefulWidget {
  final Color color;
  final bool isPlaying;
  
  const PrincessCake({
    super.key,
    required this.color,
    required this.isPlaying,
  });

  @override
  State<PrincessCake> createState() => _PrincessCakeState();
}

class _PrincessCakeState extends State<PrincessCake> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;
  late Animation<double> _sparkleAnimation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _sparkleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
    return GestureDetector(
      onTap: () {
        // Cake tap effect
        _controller.reset();
        _controller.forward();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotateAnimation.value,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    widget.color.withOpacity(0.3),
                    widget.color.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  stops: const [0.1, 0.5, 1.0],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Cake Base Layer
                  _buildCakeBase(),
                  
                  // Middle Layer
                  Positioned(
                    top: 30,
                    child: _buildCakeMiddle(),
                  ),
                  
                  // Top Layer
                  Positioned(
                    top: 20,
                    child: _buildCakeTop(),
                  ),
                  
                  // Princess Crown on Cake
                  Positioned(
                    top: 5,
                    child: Transform.scale(
                      scale: 0.8 + 0.2 * _sparkleAnimation.value,
                      child: const Icon(
                        Icons.crop,
                        color: Color(0xFFFFD700),
                        size: 40,
                      ),
                    ),
                  ),
                  
                  // Sparkles
                  if (widget.isPlaying)
                    ..._buildSparkles(),
                  
                  // Glow Effect
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.color.withOpacity(0.2 * _sparkleAnimation.value),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCakeBase() {
    return Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            widget.color.withOpacity(0.9),
            Color.lerp(widget.color, Colors.white, 0.3)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    );
  }

  Widget _buildCakeMiddle() {
    return Container(
      width: 160,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color.lerp(widget.color, Colors.white, 0.4)!,
            widget.color.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildCakeTop() {
    return Container(
      width: 140,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            widget.color.withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Candles
          Positioned(
            top: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  width: 6,
                  height: 25 + 5 * sin(_controller.value * 2 * pi + index),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFFF00),
                        const Color(0xFFFFA500),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFA500).withOpacity(0.6),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          
          // Icing Drops
          Positioned(
            bottom: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(7, (index) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSparkles() {
    final sparkles = <Widget>[];
    for (int i = 0; i < 8; i++) {
      final angle = i * (2 * pi / 8) + _controller.value * pi;
      final radius = 100.0;
      final x = radius * cos(angle);
      final y = radius * sin(angle);
      
      sparkles.add(
        Positioned(
          left: 110 + x,
          top: 110 + y,
          child: Transform.rotate(
            angle: angle,
            child: Opacity(
              opacity: 0.3 + 0.7 * sin(_controller.value * 4 * pi + i),
              child: Icon(
                Icons.star,
                color: Colors.yellow.withOpacity(0.8),
                size: 12 + 8 * sin(_controller.value * 2 * pi + i),
              ),
            ),
          ),
        ),
      );
    }
    return sparkles;
  }
}