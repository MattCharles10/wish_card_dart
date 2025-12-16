// lib/features/birthday_screen/widgets/birthday_cake.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class BirthdayCake extends StatelessWidget {
  final Color color;
  final bool isPlaying;
  
  const BirthdayCake({
    super.key,
    required this.color,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.3),
            color.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Cake base
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.8),
                ],
              ),
            ),
          ),
          
          // Cake top layer
          Positioned(
            top: 20,
            child: Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    color.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          
          // Crown
          Positioned(
            top: 5,
            child: Icon(
              Icons.crop,
              color: AppColors.gold,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}