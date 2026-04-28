import 'package:flutter/material.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/data/repositories/music_repository.dart';

class PlaylistViewmodel extends ChangeNotifier {
  bool isLoaded = false;

  List<Playlist> playlists = [];
  final MusicRepository musicRepository;

  PlaylistViewmodel({required this.musicRepository});

  void load() async {
    if(isLoaded) return;
    playlists = await musicRepository.loadPlayLists();
    isLoaded = true;
    notifyListeners();
  }

  void createPlaylist(String name, List<Music> musics) {
    musicRepository.createPlaylist(name, musics);
    notifyListeners();
  }

  void addToPlaylist(int playlistId, Music music) {
    musicRepository.addToPlaylist(playlistId, music);
    notifyListeners();
  }

  void removeFromPlaylist(int playlistId, Music music) {
    musicRepository.removeFromPlaylist(playlistId, music);
    notifyListeners();
  }
}