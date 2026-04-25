import 'dart:collection';

import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/album.dart';
import 'package:music_player/app/data/models/playlist.dart';

class ProductsRepository {
  final List<Music> _musics = [];
  final List<Album> _albums = [];
  final List<Playlist> _playlists = [];

  UnmodifiableListView<Music> get musics => UnmodifiableListView(_musics);
  UnmodifiableListView<Album> get albums => UnmodifiableListView(_albums);
  UnmodifiableListView<Playlist> get playlists => UnmodifiableListView(_playlists);

  Future<List<Music>> loadSongs() async {
    await Future.delayed(Duration(seconds: 2));
    return musics;
  }

  Future<List<Album>> loadAlbums() async {
    await Future.delayed(Duration(seconds: 2));
    return albums;
  }

  Future<List<Playlist>> loadPlayLists() async {
    await Future.delayed(Duration(seconds: 2));
    return playlists;
  }

  
}
