import 'package:go_router/go_router.dart';
import 'package:music_player/app/ui/view/music_screen.dart';
import 'package:music_player/app/ui/view/collection_screen.dart';
import 'package:music_player/app/ui/view/player_screen.dart';
import 'package:provider/provider.dart';

final class Routes {
  static const musics = '/musics';
  static const collections = '/collections';
  static const player = '/player';
}

final routes = GoRouter(
  initialLocation: Routes.musics,
  routes: [
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
    )
  ],
);