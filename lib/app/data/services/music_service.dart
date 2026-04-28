import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/data/models/album.dart';
import 'package:music_player/app/data/models/playlist.dart';

class MusicService {
  // Devolve dados mock
  Future<List<Music>> fetchMusics() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Music(id: 1, artist: "1",duration: Duration(minutes: 1, seconds: 35),name: "1"),
      Music(id: 2, artist: "2",duration: Duration(minutes: 2, seconds: 35),name: "2"),
      Music(id: 3, artist: "3",duration: Duration(minutes: 3, seconds: 35),name: "3"),
      Music(id: 4, artist: "4",duration: Duration(minutes: 4, seconds: 35),name: "4"),
      Music(id: 5, artist: "5",duration: Duration(minutes: 5, seconds: 35),name: "5"),
    ];
  }

  Future<List<Album>> fetchAlbums(List<Music> songs) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Album(
        id: 1, 
        name: "Album 1",
        artist: "Artista 1",
        coverUrl: "",
        musicList: songs.take(3).toList(),
      ),
    ];
  }

  Future<List<Playlist>> fetchPlaylists(List<Music> songs) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Playlist(
        id: 100, //mock data for testing, remove later
        name: "Favoritos",
        coverUrl: "",
        musicList: songs.take(2).toList(),
      ),
    ];
  }
}