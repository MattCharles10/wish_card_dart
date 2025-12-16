import 'package:flutter/material.dart';

class GlowingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color glowColor;
  
  const GlowingText({
    super.key,
    required this.text,
    this.fontSize = 36,
    this.glowColor = Colors.pink,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Glow effect
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = glowColor,
            shadows: [
              Shadow(
                blurRadius: 20,
                color: glowColor,
              ),
            ],
          ),
        ),
        // Solid text
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}