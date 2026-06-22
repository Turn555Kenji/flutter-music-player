import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:flutter/foundation.dart';

class PlayerViewmodel extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;
  Music? currentMusic;
  Duration currDuration = Duration.zero;
  Duration totalDuration = Duration.zero;
  List<Music> queue = [];
  int currentIndex = 0;

  PlayerViewmodel() {
    _player.playerStateStream.listen((state) {
      isPlaying = state.playing;
      notifyListeners();
    });

    _player.positionStream.listen((position) {
      currDuration = position;
      notifyListeners();
    });

    _player.durationStream.listen((duration) {
      totalDuration = duration ?? Duration.zero;
      notifyListeners();
    });

    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        next();
      }
    });
  }

  Future<void> play(Music music, {List<Music>? musicQueue}) async {
    if (music.coverUrl == null) return;

    try {
      currentMusic = music;
      if (musicQueue != null) {
        queue = musicQueue;
        currentIndex = queue.indexWhere((m) => m.id == music.id);
      }

      await _player.setFilePath(music.coverUrl!);
      await _player.play();
      notifyListeners();
    } catch (e) {
      debugPrint('Error playing music: $e');
    }
  }

  void togglePlayPause() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void next() {
    if (queue.isEmpty) return;
    if (currentIndex < queue.length - 1) {
      currentIndex++;
      play(queue[currentIndex]);
    }
  }

  void previous() {
    if (queue.isEmpty) return;
    if (currentIndex > 0) {
      currentIndex--;
      play(queue[currentIndex]);
    }
  }

  void seek(Duration position) {
    _player.seek(position);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
