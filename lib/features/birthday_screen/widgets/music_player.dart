import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/services/audio_service.dart';

class MusicPlayerWidget extends StatefulWidget {
  final String songPath;
  final Color color;

  const MusicPlayerWidget({
    super.key,
    required this.songPath,
    required this.color,
  });

  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
  final AudioService _audioService = AudioService();
  double _volume = 1.0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _audioService.playSong(widget.songPath);
    setState(() {
      _isPlaying = true;
    });
  }

  void _togglePlayPause() async {
    await _audioService.togglePlayPause();
    setState(() {
      _isPlaying = _audioService.isPlaying;
    });
  }

  void _adjustVolume(double value) async {
    await _audioService.setVolume(value);
    setState(() {
      _volume = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.color, width: 2),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            // Music Icon
            GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      widget.color,
                      widget.color.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Volume Control
            SizedBox(
              width: 150,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.volume_down,
                        color: widget.color,
                        size: 20,
                      ),
                      Expanded(
                        child: Slider(
                          value: _volume,
                          onChanged: _adjustVolume,
                          activeColor: widget.color,
                          inactiveColor: Colors.white30,
                        ),
                      ),
                      Icon(
                        Icons.volume_up,
                        color: widget.color,
                        size: 20,
                      ),
                    ],
                  ),
                  Text(
                    'Birthday Music',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}