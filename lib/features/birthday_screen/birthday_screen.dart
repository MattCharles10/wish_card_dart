// Updated birthday_screen.dart
import 'package:flutter/material.dart';
import 'dart:math';
import '../../core/constants/elakiya_wishes.dart';
import 'widgets/animated_background.dart';
import 'widgets/birthday_cake.dart';
import 'widgets/wish_card.dart';
import 'widgets/signature.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  
  final Random _random = Random();
  bool _showConfetti = false;
  int _currentWishIndex = 0;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
    
    // Auto cycle wishes
    _startAutoCycle();
  }

  void _startAutoCycle() {
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted && _isFirstLoad) {
        _nextWish();
        _isFirstLoad = false;
      }
      _startAutoCycle();
    });
  }

  void _nextWish() {
    setState(() {
      _currentWishIndex = (_currentWishIndex + 1) % ElakiyaWishes.wishes.length;
      _showConfetti = true;
    });
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showConfetti = false;
        });
      }
    });
  }

  void _previousWish() {
    setState(() {
      _currentWishIndex = (_currentWishIndex - 1) % ElakiyaWishes.wishes.length;
      if (_currentWishIndex < 0) _currentWishIndex = ElakiyaWishes.wishes.length - 1;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wish = ElakiyaWishes.wishes[_currentWishIndex];
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0014),
      body: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: AnimatedBackground(
              controller: _controller,
              color: wish.color,
            ),
          ),
          
          // Main Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Elakiya's Name with Medical Theme
                    _buildMedicalHeader(),
                    
                    const SizedBox(height: 20),
                    
                    // Medical Student Tagline
                    Text(
                      'Medical Student in Kyrgyzstan, Osh 🇰🇬',
                      style: TextStyle(
                        fontSize: 18,
                        color: wish.color.withOpacity(0.9),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    Text(
                      '1st Year Medicine 🩺',
                      style: TextStyle(
                        fontSize: 16,
                        color: wish.color.withOpacity(0.7),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Floating Medical Cake
                    AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnimation.value),
                          child: BirthdayCake(
                            color: wish.color,
                            isPlaying: true,
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Birthday Text with Medical Theme
                    _buildBirthdayText(wish.color),
                    
                    const SizedBox(height: 40),
                    
                    // Wish Card
                    WishCard(
                      wish: wish.toMap(), // Convert to map
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Navigation Controls
                    _buildMedicalNavigation(wish.color),
                    
                    const SizedBox(height: 40),
                    
                    // Signature with medical theme
                    _buildMedicalSignature(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHeader() {
    return Column(
      children: [
        Text(
          'ELAKIYA',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            fontFamily: 'DancingScript',
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [
                  const Color(0xFF2DD4BF), // Medical teal
                  const Color(0xFFFF69C5), // Pink
                  const Color(0xFFFFD700), // Gold
                ],
              ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
            shadows: [
              Shadow(
                blurRadius: 20,
                color: const Color(0xFF2DD4BF),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medical_services, color: Colors.white.withOpacity(0.7), size: 20),
            const SizedBox(width: 8),
            const Text(
              'Future Doctor',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBirthdayText(Color color) {
    return Column(
      children: [
        Text(
          'HAPPY BIRTHDAY',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
            shadows: [
              Shadow(
                blurRadius: 15,
                color: color.withOpacity(0.8),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DOCTOR ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2DD4BF),
              ),
            ),
            Text(
              'ELAKIYA! ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const Text(
              '👩‍⚕️',
              style: TextStyle(fontSize: 28),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMedicalNavigation(Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous Button
            GestureDetector(
              onTap: _previousWish,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            
            const SizedBox(width: 40),
            
            // Medical Student Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.2),
                    const Color(0xFF2DD4BF).withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Wish ${_currentWishIndex + 1}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'of ${ElakiyaWishes.wishes.length}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 40),
            
            // Next Button
            GestureDetector(
              onTap: _nextWish,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        // Dots with medical icons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            ElakiyaWishes.wishes.length,
            (index) {
              final icons = ['🩺', '📚', '🏔️', '⚕️', '🎓', '🌍'];
              return GestureDetector(
                onTap: () => setState(() {
                  _currentWishIndex = index;
                }),
                child: Container(
                  width: index == _currentWishIndex ? 50 : 35,
                  height: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index == _currentWishIndex ? color : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: index == _currentWishIndex ? color : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      icons[index],
                      style: TextStyle(
                        fontSize: index == _currentWishIndex ? 20 : 16,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalSignature() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2DD4BF).withOpacity(0.1),
            const Color(0xFF9D4EDD).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2DD4BF).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.favorite,
                color: Color(0xFFFF69C5),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Made with love for our future doctor',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Text(
            'Elakiya',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'DancingScript',
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [
                    const Color(0xFF2DD4BF),
                    const Color(0xFFFF69C5),
                  ],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),
          
          const SizedBox(height: 12),
          
          Container(
            height: 1,
            width: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF2DD4BF).withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          const Text(
            'Happy Birthday to our brilliant medical student!\n'
            'We\'re so proud of your journey in Kyrgyzstan!\n'
            'May you heal many and shine bright! 🩺💖',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Medical icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMedicalIcon(Icons.medical_services, 'Medical'),
              _buildMedicalIcon(Icons.school, 'Study'),
              _buildMedicalIcon(Icons.public, 'Global'),
              _buildMedicalIcon(Icons.celebration, 'Celebrate'),
              _buildMedicalIcon(Icons.family_restroom, 'Family'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2DD4BF).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2DD4BF),
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}