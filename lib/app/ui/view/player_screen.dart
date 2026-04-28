import 'package:flutter/material.dart';
import 'package:music_player/app/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/app/ui/viewmodel/player_viewmodel.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatelessWidget {

  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: context.watch<PlayerViewmodel>(),
      builder: (context, child) {
        final playerVm = context.read<PlayerViewmodel>();
        final music = playerVm.currentMusic;


        return Scaffold(
          appBar: AppBar(
            title: Text('Now Playing')
          ),
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey,
                  child: Icon(Icons.music_note, size: 100),
                ),
                SizedBox(height: 32),
                Text(
                  music?.name ?? 'No music selected',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  music?.artist ?? '',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                SizedBox(height: 32),

                LinearProgressIndicator(value: 0.0),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0:00'),
                    Text('3:30'),
                  ],
                ),
                SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous, size: 36),
                      onPressed: () => playerVm.previous(),
                    ),
                    IconButton(
                      icon: Icon(playerVm.isPlaying ? Icons.pause : Icons.play_arrow, size: 48),
                      onPressed: () => playerVm.togglePlayPause(),
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next, size: 36),
                      onPressed: () => playerVm.next(),
                    ),
                  ],
                ),

              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            onTap: (index) {
              if (index == 1) context.go(Routes.musics);
              if (index == 2) context.go(Routes.collections);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Currently Playing'),
              BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
              BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
            ],
          )
        );



      }
    );
  }
}