import 'package:go_router/go_router.dart';
import 'package:music_player/app/data/models/album.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/ui/view/create_playlist_screen.dart';
import 'package:music_player/app/ui/view/music_screen.dart';
import 'package:music_player/app/ui/view/login_screen.dart';
import 'package:music_player/app/ui/view/collection_screen.dart';
import 'package:music_player/app/ui/view/player_screen.dart';
import 'package:music_player/app/ui/view/inside_collection_screen.dart';
import 'package:music_player/app/ui/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

final class Routes {
  static const login = '/login';
  static const musics = '/musics';
  static const collections = '/collections';
  static const player = '/player';
  static const createPlaylist = '/create-playlist';
  static const insideCollection = '/inside-collection';
}

GoRouter createRouter(AuthViewmodel authViewmodel) {
  return GoRouter(
    initialLocation: Routes.login,
    redirect: (context, state) {
      final isLoggedIn = authViewmodel.isLoggedIn;
      final isLoginRoute = state.matchedLocation == Routes.login;

      if (isLoggedIn && isLoginRoute) return Routes.musics;
      if (!isLoggedIn && !isLoginRoute) return Routes.login;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => LoginScreen(
          authViewmodel: context.read(),
        ),
      ),
      GoRoute(
        path: Routes.musics,
        builder: (context, state) => MusicScreen(
          musicViewmodel: context.read(),
        ),
      ),
      GoRoute(
        path: Routes.collections,
        builder: (context, state) => CollectionScreen(
          albumViewmodel: context.read(),
          playlistViewmodel: context.read(),
        ),
      ),
      GoRoute(
        path: Routes.player,
        builder: (context, state) => PlayerScreen(),
      ),
      GoRoute(
        path: Routes.createPlaylist,
        builder: (context, state) {
          final playlist = state.extra as Playlist?;
          return CreatePlaylistScreen(
            musicViewmodel: context.read(),
            playlistViewmodel: context.read(),
            playlist: playlist
          );
        }
      ),
      GoRoute(
        path: Routes.insideCollection,
        builder: (context, state) {
          final extra = state.extra;
          if(extra is Album){
            return InsideCollectionScreen(
              name: extra.name,
              songs: extra.musicList,
              playlist: null
            );
          }
          else{
            final playlist = extra as Playlist;
            return InsideCollectionScreen(
              name: playlist.name,
              songs: playlist.musicList,
              playlist: playlist,
              playlistViewmodel: context.read()
            );
          }
        },
      ),
      
    ],
  );
}