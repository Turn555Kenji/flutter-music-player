import 'package:flutter/material.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/data/repositories/music_repository.dart';

class PlaylistViewmodel extends ChangeNotifier {
  final MusicRepository musicRepository;
  bool isLoaded = false;
  List<Playlist> playlists = [];

  PlaylistViewmodel({required this.musicRepository});

  void load() async {
    if (isLoaded) return;
    playlists = await musicRepository.loadPlaylists();
    isLoaded = true;
    notifyListeners();
  }

  void createPlaylist(String name, String description, List<Music> songs) async {
    await musicRepository.createPlaylist(name, description, songs);
    isLoaded = false;
    load();
  }

  void updatePlaylist(int id, String name, String description, List<Music> songs) async {
    await musicRepository.updatePlaylist(id, name, description, songs);
    isLoaded = false;
    load();
  }

  void deletePlaylist(int id) async {
    await musicRepository.deletePlaylist(id);
    isLoaded = false;
    load();
  }
}