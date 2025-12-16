import 'package:flutter/material.dart';
import 'features/birthday_screen/birthday_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BirthdayWishesApp());
}

class BirthdayWishesApp extends StatelessWidget {
  const BirthdayWishesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Birthday Elakiya! 👑',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DancingScript',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF69C5),
          brightness: Brightness.dark,
        ),
      ),
      home: const BirthdayScreen(),
    );
  }
}