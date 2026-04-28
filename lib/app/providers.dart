import 'package:provider/provider.dart';
import 'package:music_player/app/ui/viewmodel/music_viewmodel.dart';
import 'package:music_player/app/ui/viewmodel/album_viewmodel.dart';
import 'package:music_player/app/ui/viewmodel/playlist_viewmodel.dart';
import 'package:music_player/app/ui/viewmodel/player_viewmodel.dart';
import 'package:music_player/app/data/repositories/music_repository.dart';

final providers = [
  Provider<MusicRepository>(
    create: (context) => MusicRepository(),
  ),
  ChangeNotifierProvider<MusicViewmodel>(
    create: (context) => MusicViewmodel(
      musicRepository: context.read(),
    ),
  ),
  ChangeNotifierProvider<AlbumViewmodel>(
    create: (context) => AlbumViewmodel(
      musicRepository: context.read(),
    ),
  ),
  ChangeNotifierProvider<PlaylistViewmodel>(
    create: (context) => PlaylistViewmodel(
      musicRepository: context.read(),
    ),
  ),
  ChangeNotifierProvider<PlayerViewmodel>(
    create: (context) => PlayerViewmodel(),
  )
];