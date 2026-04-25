import 'package:music_player/app/data/models/music.dart';

class Album {
  final int id;
  final String name;
  final String artist;
  final String coverUrl;
  final List<Music> musicList;

  Album({required this.id, required this.name, required this.artist, required this.coverUrl, required this.musicList});
}
