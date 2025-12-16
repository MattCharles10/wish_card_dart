
import 'package:flutter/material.dart';

class BirthdayWish {
  final String title;
  final String message;
  final String icon;
  final Color color;
  final String musicPath;

  const BirthdayWish({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
    required this.musicPath,
  });

  factory BirthdayWish.fromMap(Map<String, dynamic> map) {
    return BirthdayWish(
      title: map['title'] as String,
      message: map['message'] as String,
      icon: map['icon'] as String,
      color: map['color'] as Color,
      musicPath: map['musicPath'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'icon': icon,
      'color': color,
      'musicPath': musicPath,
    };
  }

  void operator [](String other) {}
}