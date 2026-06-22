import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/album.dart';

class MusicService {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<bool> requestPermission() async {
    final status = await Permission.audio.request();
    if (status.isDenied) {
      final storageStatus = await Permission.storage.request();
      return storageStatus.isGranted;
    }
    return status.isGranted;
  }

  Future<List<Music>> fetchMusics() async {
    final granted = await requestPermission();
    if (!granted) return [];

    final songs = await _audioQuery.querySongs(
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    // filter to /Music
    final filtered = songs.where((song) =>
      song.data.contains('/Music')
    ).toList();

    return filtered.map((song) => Music(
      id: song.id,
      name: song.title,
      artist: song.artist ?? 'Unknown Artist',
      duration: Duration(milliseconds: song.duration ?? 0),
      coverUrl: song.data,
    )).toList();
  }

  Future<List<Album>> fetchAlbums(List<Music> songs) async {
    final granted = await requestPermission();
    if (!granted) return [];

    final albums = await _audioQuery.queryAlbums(
      sortType: AlbumSortType.ALBUM,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    return albums.map((album) {
      final albumSongs = songs
          .where((s) => s.artist == album.artist)
          .toList();

      return Album(
        id: album.id,
        name: album.album,
        artist: album.artist ?? 'Unknown Artist',
        coverUrl: album.id.toString(),
        musicList: albumSongs,
      );
    }).toList();
  }
}