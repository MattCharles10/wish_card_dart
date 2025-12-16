class MusicConstants {
  static const List<BirthdaySong> songs = [
    BirthdaySong(
      title: "Happy Birthday",
      path: "assets/music/happy_birthday.mp3",
      artist: "Traditional",
      duration: "0:45",
    ),
    BirthdaySong(
      title: "Celebration Time",
      path: "assets/music/celebration.mp3",
      artist: "Party Music",
      duration: "2:30",
    ),
    BirthdaySong(
      title: "Joyful Moments",
      path: "assets/music/joyful.mp3",
      artist: "Instrumental",
      duration: "3:15",
    ),
  ];
}

class BirthdaySong {
  final String title;
  final String path;
  final String artist;
  final String duration;

  const BirthdaySong({
    required this.title,
    required this.path,
    required this.artist,
    required this.duration,
  });
}