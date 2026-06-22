class Music {
  final int id;
  final String name;
  final String artist;
  final Duration duration;
  final String? coverUrl;
  final String album;

  Music({required this.id, required this.name, required this.artist, required this.duration, this.coverUrl, required this.album});
}
