// lib/core/theme/text_theme.dart
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTextTheme {
  // Main text styles
  static TextStyle get titleStyle {
    return const TextStyle(
      fontSize: 42,
      fontWeight: FontWeight.w900,
      color: Colors.white,
      fontFamily: 'DancingScript',
      height: 1.2,
    );
  }
  
  static TextStyle get subtitleStyle {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
      height: 1.4,
    );
  }
  
  static TextStyle get wishTitleStyle {
    return const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: [
        Shadow(
          blurRadius: 10,
          color: Colors.black54,
        ),
      ],
    );
  }
  
  static TextStyle get wishMessageStyle {
    return const TextStyle(
      fontSize: 18,
      color: Colors.white,
      height: 1.6,
      fontWeight: FontWeight.w400,
    );
  }
  
  static TextStyle get buttonTextStyle {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }
  
  static TextStyle get signatureStyle {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.textSecondary,
      fontStyle: FontStyle.italic,
      height: 1.4,
    );
  }
  
  // Elakiya special name style
  static TextStyle get elakiyaNameStyle {
    return TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w900,
      fontFamily: 'DancingScript',
      foreground:  Paint()
        ..shader = const LinearGradient(
          colors: [
            AppColors.accentColor,
            AppColors.purple,
            AppColors.gold,
          ],
        ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
      shadows: const [
        Shadow(
          blurRadius: 20,
          color: AppColors.accentColor,
        ),
        Shadow(
          blurRadius: 40,
          color: AppColors.gold,
        ),
      ],
    );
  }
}