import 'package:music_player/app/data/models/music.dart';

class Playlist {
  final int id;
  final String name;
  final String? coverUrl;
  final List<Music> musicList;

  Playlist({required this.id, required this.name, this.coverUrl, required this.musicList});
}
