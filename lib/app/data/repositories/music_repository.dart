import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:music_player/app/data/database/database_service.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/album.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/data/repositories/authentication_repository.dart';
import 'package:music_player/app/data/services/music_service.dart';

class MusicRepository {
  final MusicService _service = MusicService();
  final DatabaseService _databaseService = DatabaseService();
  final AuthRepository authRepository;

  final List<Music> _musics = [];
  final List<Album> _albums = [];

  String? _savedFolderPath;

  MusicRepository({required this.authRepository});

  UnmodifiableListView<Music> get musics => UnmodifiableListView(_musics);
  UnmodifiableListView<Album> get albums => UnmodifiableListView(_albums);

  Future<List<Music>> loadMusics() async {
    try {
      _savedFolderPath ??= await _service.pickFolder();
      if (_savedFolderPath == null) return musics;

      final result = await _service.fetchMusicsFromFolder(_savedFolderPath!);
      if (result.isEmpty) return musics;
      _musics.clear();
      _musics.addAll(result);
      return musics;
    } catch (e) {
      debugPrint('Error loading musics: $e');
      return musics;
    }
  }

  Future<List<Music>> changeFolder() async {
    _savedFolderPath = await _service.pickFolder();
    return loadMusics();
  }

  Future<List<Album>> loadAlbums() async {
  if (_musics.isEmpty) await loadMusics();

  final grouped = <String, List<Music>>{};
    for (final music in _musics) {
      (grouped[music.album] ??= []).add(music);
    }

    _albums.clear();
    _albums.addAll(grouped.entries.map((e) => Album(
      id: e.key.hashCode,
      name: e.key,
      artist: e.value.first.artist,
      coverUrl: '',
      musicList: e.value,
    )));
    return albums;
  }

  Future<List<Playlist>> loadPlaylists() async {
    if (_musics.isEmpty) {
      await loadMusics(); // music must load first
    }

    final userId = authRepository.currentUserId;
    if (userId == null) return [];

    final playlistMaps = await _databaseService.getPlaylists(userId);
    final playlists = <Playlist>[];

    for (final map in playlistMaps) {
      final songMaps = await _databaseService.getPlaylistSongs(map['id'] as int);
      
      // match song paths to actual Music objects
      final songs = songMaps.map((songMap) {
        return _musics.firstWhere(
          (m) => m.id.toString() == songMap['song_path'],
          orElse: () => _musics.first,
        );
      }).toList();

      playlists.add(Playlist(
        id: map['id'] as int,
        name: map['name'] as String,
        coverUrl: map['cover_url'] as String? ?? '',
        musicList: songs,
      ));
    }

    return playlists;
  }

  Future<void> createPlaylist(String name, String description, List<Music> songs) async {
    final userId = authRepository.currentUserId;
    if (userId == null) return;

    final playlistId = await _databaseService.insertPlaylist(
      userId,
      name,
      description,
      null,
    );

    for (int i = 0; i < songs.length; i++) {
      await _databaseService.insertPlaylistSong(
        playlistId,
        songs[i].id.toString(), // store id as path for now
        i,
      );
    }
  }

  Future<void> updatePlaylist(int id, String name, String description, List<Music> songs) async {
    await _databaseService.updatePlaylist(id, name, description);

    // delete old songs and reinsert
    await _databaseService.deletePlaylistSongs(id);
    for (int i = 0; i < songs.length; i++) {
      await _databaseService.insertPlaylistSong(
        id,
        songs[i].id.toString(),
        i,
      );
    }
  }

  Future<void> deletePlaylist(int id) async {
    await _databaseService.deletePlaylist(id);
  }
}