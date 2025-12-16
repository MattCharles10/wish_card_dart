// lib/features/birthday_screen/providers/birthday_provider.dart
import 'package:birthday_wishes_sister/core/models/birthday_wish.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants/elakiya_wishes.dart';

class BirthdayProvider extends ChangeNotifier {
  int _currentWishIndex = 0;
  bool _isMusicPlaying = true;
  double _musicVolume = 0.7;
  bool _showConfetti = false;
  bool _showHearts = false;
  
  int get currentWishIndex => _currentWishIndex;
  bool get isMusicPlaying => _isMusicPlaying;
  double get musicVolume => _musicVolume;
  bool get showConfetti => _showConfetti;
  bool get showHearts => _showHearts;
  
  // FIXED: Now using BirthdayWish class
  BirthdayWish get currentWish => ElakiyaWishes.wishes[_currentWishIndex];
  
  void nextWish() {
    _currentWishIndex = (_currentWishIndex + 1) % ElakiyaWishes.wishes.length;
    _triggerCelebration();
    notifyListeners();
  }
  
  void previousWish() {
    _currentWishIndex = (_currentWishIndex - 1) % ElakiyaWishes.wishes.length;
    if (_currentWishIndex < 0) {
      _currentWishIndex = ElakiyaWishes.wishes.length - 1;
    }
    _triggerCelebration();
    notifyListeners();
  }
  
  void setWishIndex(int index) {
    if (index >= 0 && index < ElakiyaWishes.wishes.length) {
      _currentWishIndex = index;
      _triggerCelebration();
      notifyListeners();
    }
  }
  
  void toggleMusic() {
    _isMusicPlaying = !_isMusicPlaying;
    notifyListeners();
  }
  
  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    notifyListeners();
  }
  
  void _triggerCelebration() {
    _showConfetti = true;
    _showHearts = true;
    
    // Auto hide after animation
    Future.delayed(const Duration(milliseconds: 1500), () {
      _showConfetti = false;
      notifyListeners();
    });
    
    Future.delayed(const Duration(milliseconds: 2500), () {
      _showHearts = false;
      notifyListeners();
    });
  }
  
  void resetCelebration() {
    _showConfetti = false;
    _showHearts = false;
    notifyListeners();
  }
}