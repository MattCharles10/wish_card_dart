class AppTexts {
  // Birthday Messages
  static const String appTitle = 'Happy Birthday Elakiya! 👑';
  static const String tagline = 'A Special Celebration for a Special Sister';
  
  // Wishes
  static const List<String> birthdayWishes = [
    "May your birthday be as beautiful and bright as you are, Elakiya! ✨",
    "Wishing you endless happiness, success, and love today and always! 💖",
    "May all your dreams come true and your year be filled with blessings! 🌟",
    "You deserve the world and more on your special day, dear sister! 👑",
    "Here's to more laughter, adventures, and beautiful memories together! 🎉",
  ];
  
  // Button Texts
  static const String nextWish = 'Next Wish';
  static const String previousWish = 'Previous Wish';
  static const String playMusic = 'Play Music';
  static const String pauseMusic = 'Pause Music';
  static const String volume = 'Volume';
  
  // Signature
  static const String madeWithLove = 'Made with 💖 for Elakiya';
  static const String signature = 'Happy Birthday from your loving sibling! 🎂';
  
  // Music Player
  static const String nowPlaying = 'Now Playing';
  static const String birthdaySong = 'Happy Birthday Song';
  static const String celebrationMusic = 'Celebration Music';
  
  // Navigation
  static const String swipeMessage = 'Swipe or tap buttons to see more wishes';
  static const String tapForMagic = 'Tap the cake for a surprise!';
  
  // Animation Labels
  static const String confetti = '🎉 Confetti Time!';
  static const String sparkles = '✨ Sparkles!';
  static const String hearts = '💖 Hearts for You!';
  
  // Time-based Messages
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning, Elakiya! ☀️';
    if (hour < 17) return 'Good Afternoon, Elakiya! 🌤️';
    if (hour < 21) return 'Good Evening, Elakiya! 🌙';
    return 'Good Night, Elakiya! 🌟';
  }
  
  static String getBirthdayMessage() {
    return "Happy Birthday to the most amazing sister in the world! "
           "May your special day be filled with love, laughter, and joy! 🎂🎈";
  }
}