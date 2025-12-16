import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  double _volume = 1.0;

  bool get isPlaying => _isPlaying;
  double get volume => _volume;

  Future<void> playBirthdaySong() async {
    try {
      await _audioPlayer.play(AssetSource('music/happy_birthday.mp3'));
      _isPlaying = true;
    } catch (e) {
      debugPrint('Error playing music: $e');
    }
  }

  Future<void> playSong(String path) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(path));
      _isPlaying = true;
    } catch (e) {
      debugPrint('Error playing song: $e');
    }
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }

  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    await _audioPlayer.setVolume(_volume);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}