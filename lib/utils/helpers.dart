import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AppHelpers {
  // Generate a random color
  static Color randomColor({double opacity = 1.0}) {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      opacity,
    );
  }
  
  // Generate a random pastel color
  static Color randomPastelColor({double opacity = 1.0}) {
    final random = Random();
    return Color.fromRGBO(
      128 + random.nextInt(128), // 128-255
      128 + random.nextInt(128), // 128-255
      128 + random.nextInt(128), // 128-255
      opacity,
    );
  }
  
  // Generate a random bright color
  static Color randomBrightColor({double opacity = 1.0}) {
    final random = Random();
    final hue = random.nextDouble() * 360;
    return HSLColor.fromAHSL(opacity, hue, 0.8, 0.7).toColor();
  }
  
  // Calculate text color based on background brightness
  static Color textColorForBackground(Color backgroundColor) {
    final brightness = backgroundColor.computeLuminance();
    return brightness > 0.5 ? Colors.black : Colors.white;
  }
  
  // Create a shimmer gradient
  static Shader shimmerGradient(Rect rect, {List<Color>? colors}) {
    return LinearGradient(
      colors: colors ?? [
        Colors.transparent,
        Colors.white.withOpacity(0.3),
        Colors.transparent,
      ],
      stops: const [0.0, 0.5, 1.0],
      tileMode: TileMode.mirror,
    ).createShader(rect);
  }
  
  // Format duration to MM:SS
  static String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
  
  // Get greeting based on time of day
  static String getTimeGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    if (hour < 21) return 'Good Evening';
    return 'Good Night';
  }
  
  // Generate birthday message based on age
  static String getBirthdayMessage(String name, int age) {
    final messages = [
      "Happy $age${_getOrdinal(age)} Birthday, $name! 🎂",
      "Wishing you a fabulous $age${_getOrdinal(age)} birthday, $name! 🎉",
      "May your $age${_getOrdinal(age)} birthday be filled with joy, $name! ✨",
      "Cheers to $age amazing years, $name! Happy Birthday! 🥂",
      "Here's to celebrating you on your $age${_getOrdinal(age)} birthday! 🎈",
    ];
    return messages[Random().nextInt(messages.length)];
  }
  
  static String _getOrdinal(int number) {
    if (number % 100 >= 11 && number % 100 <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }
  
  // Create a celebratory emoji string
  static String getCelebrationEmojis({int count = 5}) {
    const emojis = ['🎉', '🎂', '🎈', '🎁', '✨', '🥳', '🎊', '👑', '💖', '🌟'];
    final random = Random();
    final result = StringBuffer();
    
    for (int i = 0; i < count; i++) {
      result.write(emojis[random.nextInt(emojis.length)]);
    }
    
    return result.toString();
  }
  
  // Calculate confetti count based on screen size
  static int getConfettiCount(Size screenSize) {
    final area = screenSize.width * screenSize.height;
    return max(50, min(200, (area / 10000).round()));
  }
  
  // Get random wish from list
  static String getRandomWish(List<String> wishes) {
    return wishes[Random().nextInt(wishes.length)];
  }
  
  // Create a gradient border
  static BoxDecoration gradientBorderDecoration({
    required List<Color> colors,
    double width = 2.0,
    double borderRadius = 20.0,
    Color? fillColor,
  }) {
    return BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
  
  // Create a shimmer animation controller
  static AnimationController createShimmerController(TickerProvider vsync) {
    return AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    )..repeat(reverse: true);
  }
  
  // Debounce function
  static Function debounce(Function func, Duration delay) {
    Timer? timer;
    return () {
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(delay, () => func());
    };
  }
  
  // Throttle function
  static Function throttle(Function func, Duration duration) {
    bool waiting = false;
    return () {
      if (!waiting) {
        func();
        waiting = true;
        Timer(duration, () => waiting = false);
      }
    };
  }
}