import 'package:flutter/material.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/repositories/music_repository.dart';

class MusicViewmodel extends ChangeNotifier {
  bool isLoaded = false;

  List<Music> musics = [];
  final MusicRepository musicRepository;

  MusicViewmodel({required this.musicRepository});

  void load() async {
    musics = await musicRepository.loadMusics();
    isLoaded = true;
    notifyListeners();
  }
}