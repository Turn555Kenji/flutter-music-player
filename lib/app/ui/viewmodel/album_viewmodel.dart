import 'package:flutter/material.dart';
import 'package:music_player/app/data/models/album.dart';
import 'package:music_player/app/data/repositories/music_repository.dart';

class AlbumViewmodel extends ChangeNotifier {
  bool isLoaded = false;

  List<Album> albums = [];
  final MusicRepository musicRepository;

  AlbumViewmodel({required this.musicRepository});

  void load() async {
    if(isLoaded) return;
    albums = await musicRepository.loadAlbums();
    isLoaded = true;
    notifyListeners();
  }
}