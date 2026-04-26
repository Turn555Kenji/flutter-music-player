import 'dart:collection';

import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/album.dart';
import 'package:music_player/app/data/models/playlist.dart';

int i = 1; //Replace later for real IDs

class MusicRepository {
  final List<Music> _musics = [];
  final List<Album> _albums = [];
  final List<Playlist> _playlists = [];

  UnmodifiableListView<Music> get musics => UnmodifiableListView(_musics);
  UnmodifiableListView<Album> get albums => UnmodifiableListView(_albums);
  UnmodifiableListView<Playlist> get playlists => UnmodifiableListView(_playlists);

  Future<List<Music>> loadMusics() async {
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

  void createPlaylist(String name) {
    _playlists.add(
      Playlist(
        id: i,
        name: name,
        coverUrl: "",
        musicList: [],
      ),
    );
    i=i+1;
  }

  void addToPlaylist(int playlistId, Music song) {
    final index = _playlists.indexWhere((pl) => pl.id == playlistId); //iterates over _playlists with pl
    if (index == -1) return;

    final playlist = _playlists[index];

    // musica ja existe na pl
    final alreadyExists = playlist.musicList.any((m) => m.id == song.id);
    if (alreadyExists) return;

    _playlists[index] = Playlist(
      id: playlist.id,
      name: playlist.name,
      coverUrl: playlist.coverUrl,
      musicList: [...playlist.musicList, song],
    );
  }

  void removeFromPlaylist(int playlistId, Music song) {
    final index = _playlists.indexWhere((pl) => pl.id == playlistId);
    if (index == -1) return;

    final playlist = _playlists[index];

    final updatedSongs = playlist.musicList.where((m) => m.id != song.id).toList();

    _playlists[index] = Playlist(
      id: playlist.id,
      name: playlist.name,
      coverUrl: playlist.coverUrl,
      musicList: updatedSongs,
    );
  }
}
