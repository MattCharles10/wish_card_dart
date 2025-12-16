// lib/features/birthday_screen/widgets/wish_card.dart
import 'package:flutter/material.dart';
import '../../../core/theme/text_theme.dart';

class WishCard extends StatelessWidget {
  final Map<String, dynamic> wish;
  
  const WishCard({
    super.key,
    required this.wish,
  });

  @override
  Widget build(BuildContext context) {
    final color = wish['color'] as Color;
    final icon = wish['icon'] as String;
    final title = wish['title'] as String;
    final message = wish['message'] as String;

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.25),
            color.withOpacity(0.15),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 50),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            title,
            style: AppTextTheme.wishTitleStyle,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          Container(
            height: 2,
            width: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0),
                  color,
                  color.withOpacity(0),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            message,
            style: AppTextTheme.wishMessageStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}