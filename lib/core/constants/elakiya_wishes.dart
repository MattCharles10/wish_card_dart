// lib/core/constants/elakiya_wishes.dart
import 'package:flutter/material.dart';
import '../models/birthday_wish.dart';

class ElakiyaWishes {
  static final List<BirthdayWish> wishes = [
    BirthdayWish(
      title: 'Happy Birthday Future Doctor! 🩺',
      message: "Happy Birthday to our brilliant medical student in Kyrgyzstan! May your journey in Osh be filled with success, knowledge, and amazing experiences as you pursue your dream of becoming a doctor! 🎂✨",
      icon: '🩺',
      color: const Color(0xFF2DD4BF), // Medical teal
      musicPath: 'audio/happy_birthday.mp3',
    ),
    BirthdayWish(
      title: 'Medical Student Pride! 📚',
      message: "Wishing the happiest birthday to our smart, dedicated sister studying medicine in Osh! Your hard work and determination inspire us all. May this year bring you closer to your dreams! 💖🌟",
      icon: '📚',
      color: const Color(0xFF9D4EDD), // Royal purple
      musicPath: 'audio/celebration.mp3',
    ),
    BirthdayWish(
      title: 'Osh to Success! 🌄',
      message: "Happy Birthday from your family! Even though you're studying in Kyrgyzstan, know that we're cheering for you every step of the way. May your time in Osh be filled with growth and beautiful memories! ✨👑",
      icon: '🏔️',
      color: const Color(0xFF87CEEB), // Sky blue
      musicPath: 'audio/dreams.mp3',
    ),
    BirthdayWish(
      title: 'Doctor in the Making! ⚕️',
      message: "To our future doctor celebrating her birthday far from home - your courage and dedication shine bright! May your medical studies bring you joy and your path be filled with success! 👩‍⚕️🎉",
      icon: '⚕️',
      color: const Color(0xFFFF69C5), // Princess pink
      musicPath: 'audio/princess.mp3',
    ),
    BirthdayWish(
      title: '1 Year in Kyrgyzstan! 🎓',
      message: "Happy Birthday to our amazing sister who's completing 1 year of medical studies in Kyrgyzstan! We're so proud of your journey and can't wait to see you become the incredible doctor you're meant to be! 🎈🥳",
      icon: '🎓',
      color: const Color(0xFFFFD700), // Gold
      musicPath: 'audio/joyful.mp3',
    ),
    BirthdayWish(
      title: 'Global Medical Scholar! 🌍',
      message: "Celebrating your birthday and your international medical education journey! From Osh to the world - may you heal many and shine bright in the medical field! Your global perspective makes you special! ✨💉",
      icon: '🌍',
      color: const Color(0xFFFF7F50), // Coral
      musicPath: 'audio/global.mp3',
    ),
  ];
}