class Music {
  final int id;
  final String name;
  final String artist;
  final Duration duration;
  final String? coverUrl;

  Music({required this.id, required this.name, required this.artist, required this.duration, this.coverUrl});
}
