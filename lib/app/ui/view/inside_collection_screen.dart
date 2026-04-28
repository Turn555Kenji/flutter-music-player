import 'package:flutter/material.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/ui/viewmodel/music_viewmodel.dart';
import 'package:music_player/app/widgets/music_item.dart';
import 'package:music_player/app/widgets/miniplayer.dart';
import 'package:music_player/app/routes.dart';
import 'package:go_router/go_router.dart';

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
            onPressed: () {},
          );
        },
      ),
      bottomNavigationBar: MiniPlayer(
        isPlaying: false,
        currTime: Duration.zero,
        totalTime: Duration(minutes: 3, seconds: 30),
        onPlayPause: () {},
        onNext: () {},
        onPrevious: () {},
        onTap: () {},
      )
    );
  }
}