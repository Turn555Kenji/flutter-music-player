import 'package:flutter/material.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/widgets/music_item.dart';
import 'package:music_player/app/widgets/miniplayer.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/app/ui/viewmodel/player_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:music_player/app/routes.dart';

class InsideCollectionScreen extends StatelessWidget {
  final String name;
  final List<Music> songs;

  const InsideCollectionScreen({
    super.key,
    required this.name,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final music = songs[index];
          return MusicItem(
            name: music.name,
            artist: music.artist,
            duration: music.duration,
            onPressed: () {
              context.read<PlayerViewmodel>().play(music);
            },
          );
        },
      ),
      
      bottomNavigationBar: ListenableBuilder(
        listenable: context.watch<PlayerViewmodel>(),
        builder: (context, child) {
          final playerVm = context.read<PlayerViewmodel>();
          return MiniPlayer(
            isPlaying: playerVm.isPlaying,
            currTime: playerVm.currDuration,
            totalTime: playerVm.currentMusic?.duration ?? Duration.zero,
            onPlayPause: () => playerVm.togglePlayPause(),
            onNext: () => playerVm.next(),
            onPrevious: () => playerVm.previous(),
            onTap: () => context.go(Routes.player, extra: 1),
          );
        },
      )
    );
  }
}