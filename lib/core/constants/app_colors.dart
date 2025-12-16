// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Main theme colors
  static const Color primaryColor = Color(0xFF6A11CB);
  static const Color secondaryColor = Color(0xFF2575FC);
  static const Color accentColor = Color(0xFFFF69C5);
  static const Color backgroundColor = Color(0xFF0A0014);
  static const Color surfaceColor = Color(0xFF1A0033);
  
  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFF64748B);
  
  // Decorative colors
  static const Color gold = Color(0xFFFFD700);
  static const Color pink = Color(0xFFFF69C5);
  static const Color purple = Color(0xFF9D4EDD);
  static const Color blue = Color(0xFF87CEEB);
  static const Color teal = Color(0xFF2DD4BF);
  static const Color orange = Color(0xFFFFA500);
  
  // Gradient presets
  static List<Color> get primaryGradient => [primaryColor, secondaryColor];
  static List<Color> get pinkPurpleGradient => [pink, purple];
  static List<Color> get goldGradient => [gold, orange];
  
  // Helper method
  static Color getRandomColor() {
    final colors = [pink, purple, gold, blue, teal, orange];
    return colors[DateTime.now().millisecond % colors.length];
  }
}