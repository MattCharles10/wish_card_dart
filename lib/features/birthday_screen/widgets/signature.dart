import 'package:flutter/material.dart';
import '../../../core/theme/text_theme.dart';

class Signature extends StatelessWidget {
  const Signature({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFF69C5).withOpacity(0.1),
            const Color(0xFF9D4EDD).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Made with love
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.favorite,
                color: Color(0xFFFF69C5),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Made with love for',
                style: AppTextTheme.signatureStyle.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Elakiya's name
          Text(
            'Elakiya',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'DancingScript',
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [
                    const Color(0xFFFF69C5),
                    const Color(0xFFFFD700),
                    const Color(0xFFFF69C5),
                  ],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Divider
          Container(
            height: 1,
            width: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFFFFD700).withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Birthday message
          Text(
            'Happy Birthday to the most amazing sister!\n'
            'May your day be filled with joy, laughter, and love! 🎂🎉',
            style: AppTextTheme.signatureStyle.copyWith(
              fontSize: 16,
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Decorative icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDecorativeIcon(Icons.cake, const Color(0xFFFF69C5)),
              _buildDecorativeIcon(Icons.star, const Color(0xFFFFD700)),
              _buildDecorativeIcon(Icons.celebration, const Color(0xFF9D4EDD)),
              _buildDecorativeIcon(Icons.favorite, const Color(0xFFFF69C5)),
              _buildDecorativeIcon(Icons.music_note, const Color(0xFF87CEEB)),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Copyright
          Text(
            '© ${DateTime.now().year} Birthday Wishes App',
            style: AppTextTheme.signatureStyle.copyWith(
              fontSize: 12,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeIcon(IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }
}