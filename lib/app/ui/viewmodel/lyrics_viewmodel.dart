import 'package:flutter/material.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/services/lyrics_service.dart';

class LyricsViewmodel extends ChangeNotifier {
  final LyricsService _service = LyricsService();

  bool isLoading = false;
  bool isSearching = false;
  LyricsResult? current;
  List<LyricsResult> searchResults = [];
  String? error;

  String buildQuery(Music music) {
    final artist = music.artist == 'Unknown Artist' ? '' : music.artist;
    return '$artist ${music.name}'.trim();
  }

  Future<void> loadForMusic(Music music) async {
    isLoading = true;
    current = null;
    error = null;
    searchResults = [];
    notifyListeners();

    try {
      final query = buildQuery(music);
      final results = await _service.search(query);
      if (results.isNotEmpty) current = results.first;
      if (current == null) error = 'No lyrics found';
    } catch (e) {
      error = 'Failed to fetch lyrics';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> search(String query) async {
    isSearching = true;
    searchResults = [];
    notifyListeners();

    try {
      searchResults = await _service.search(query);
      if (searchResults.isEmpty) error = 'No results found';
    } catch (e) {
      error = 'Search failed';
    }

    isSearching = false;
    notifyListeners();
  }

  void selectResult(LyricsResult result) {
    current = result;
    searchResults = [];
    error = null;
    notifyListeners();
  }

  void clearSearch() {
    searchResults = [];
    notifyListeners();
  }
}