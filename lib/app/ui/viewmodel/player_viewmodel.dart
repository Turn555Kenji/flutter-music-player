import 'package:flutter/material.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/repositories/music_repository.dart';

class PlayerViewmodel extends ChangeNotifier {
  bool isPlaying = false;
  Music? currentMusic;
  Duration currDuration = Duration.zero;
  Duration totalDuration = Duration.zero;

  void play(Music music) {
    currentMusic = music;
    isPlaying = true;
    totalDuration = music.duration;
    currDuration = Duration.zero;
    notifyListeners();
  }

  void togglePlayPause() {
    if(isPlaying) {
      isPlaying = false;
    } else {
      isPlaying = true;
    }
    notifyListeners();
  }

  //rascunho
  void next() {
    notifyListeners();
  }

  void previous() {
    notifyListeners(); 
  }
}