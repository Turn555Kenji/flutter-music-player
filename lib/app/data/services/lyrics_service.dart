import 'dart:convert';
import 'package:http/http.dart' as http;

class LyricsResult {
  final int id;
  final String trackName;
  final String artistName;
  final String albumName;
  final double duration;
  final String? plainLyrics;
  final String? syncedLyrics;

  LyricsResult({
    required this.id,
    required this.trackName,
    required this.artistName,
    required this.albumName,
    required this.duration,
    this.plainLyrics,
    this.syncedLyrics,
  });

  factory LyricsResult.fromJson(Map<String, dynamic> json) {
    return LyricsResult(
      id: json['id'] as int,
      trackName: json['trackName'] as String? ?? '',
      artistName: json['artistName'] as String? ?? '',
      albumName: json['albumName'] as String? ?? '',
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      plainLyrics: json['plainLyrics'] as String?,
      syncedLyrics: json['syncedLyrics'] as String?,
    );
  }
}

class LyricsService {
  static const _base = 'https://lrclib.net/api';

  String _clean(String text) => text
      .replaceAll(RegExp(r'\(feat\..*?\)', caseSensitive: false), '')
      .replaceAll(RegExp(r'\[.*?\]'), '')
      .trim();

  Future<LyricsResult?> fetchExact(String artist, String title, String album, Duration duration) async {
    final params = {
      'artist_name': _clean(artist),
      'track_name': _clean(title),
      'album_name': album,
      if (duration.inSeconds > 0) 'duration': duration.inSeconds.toString(),
    };

    final uri = Uri.parse('$_base/get').replace(queryParameters: params);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return LyricsResult.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<LyricsResult>> search(String query) async {
    final uri = Uri.parse('$_base/search').replace(queryParameters: {'q': query});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => LyricsResult.fromJson(e as Map<String, dynamic>)).toList();
    }
    return [];
  }
}