// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      // Basic theme setup
      brightness: Brightness.dark,
      useMaterial3: true,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      
      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'DancingScript',
        ),
      ),
      
      // Text Theme (simplified)
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'DancingScript',
        ),
        displayMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: AppColors.accentColor,
          fontFamily: 'DancingScript',
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: Colors.white,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
      
      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.accentColor,
        size: 24,
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentColor,
        foregroundColor: Colors.white,
      ),
      
      // Input Decoration Theme (optional, for any text fields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.accentColor,
            width: 2,
          ),
        ),
      ),
    );
  }
  
  // Custom text styles for the app
  static TextStyle get glitterText {
    return const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      fontFamily: 'DancingScript',
      shadows: [
        Shadow(
          blurRadius: 10,
          color: AppColors.gold,
        ),
        Shadow(
          blurRadius: 20,
          color: AppColors.accentColor,
        ),
      ],
    );
  }
  
  static TextStyle get glowText {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w900,
      fontFamily: 'DancingScript',
      foreground:  Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..color = AppColors.accentColor.withOpacity(0.5),
      shadows: const [
        Shadow(
          blurRadius: 15,
          color: AppColors.accentColor,
        ),
      ],
    );
  }
}