import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/album.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';

class MusicService {

  Future<bool> _requestStoragePermission() async {
    if (await Permission.manageExternalStorage.isGranted) return true;
    final status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }

  String _toRealPath(String uri) {
    if (uri.startsWith('content://')) {
      final encoded = uri.split('/document/').last;
      final decoded = Uri.decodeComponent(encoded);
      if (decoded.startsWith('primary:')) {
        return '/storage/emulated/0/${decoded.substring('primary:'.length)}';
      }
    }
    return uri;
  }

  Future<String?> pickFolder() async {
    await _requestStoragePermission();
    return await FilePicker.platform.getDirectoryPath();
  }

  Future<List<Music>> fetchMusicsFromFolder(String folderPath) async {
    await _requestStoragePermission();
    
    final realPath = _toRealPath(folderPath);
    final dir = Directory(realPath);

    if (!await dir.exists()) {
      return [];
    }

    final audioExtensions = {'.mp3', '.flac', '.wav', '.aac', '.m4a'};

    final files = await dir
        .list(recursive: true)
        .where((f) =>
            f is File &&
            audioExtensions.contains(
                f.path.substring(f.path.lastIndexOf('.')).toLowerCase()))
        .toList();

    final musics = <Music>[];
    for (final entry in files.asMap().entries) {
      final file = entry.value as File;
      final metadata = await readMetadata(file, getImage: false);
      final name = file.path.split(Platform.pathSeparator).last;
      final dir = file.path.substring(0, file.path.lastIndexOf(Platform.pathSeparator));
      final cover = _findCoverInDirectory(dir);
      musics.add(Music(
        id: entry.key,
        name: metadata.title ?? name.replaceAll(RegExp(r'\.(mp3|flac|wav|aac|m4a)$', caseSensitive: false), ''),
        artist: metadata.artist ?? 'Unknown Artist',
        album: metadata.album ?? 'Unknown Album',
        duration: metadata.duration ?? Duration.zero,
        coverUrl: cover,
        filePath: file.path
      ));
    }
    return musics;
  }

  String? _findCoverInDirectory(String dirPath) {
    for (final ext in ['cover.jpg', 'cover.jpeg', 'cover.png']) {
      final file = File('$dirPath${Platform.pathSeparator}$ext');
      if (file.existsSync()) return file.path;
    }
    return null;
  }

  Future<List<Album>> fetchAlbums(List<Music> songs) async => [];
  Future<List<Playlist>> fetchPlaylists(List<Music> songs) async => [];
}