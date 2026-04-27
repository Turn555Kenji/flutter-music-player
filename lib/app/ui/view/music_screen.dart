import 'package:flutter/material.dart';
import 'package:music_player/app/ui/viewmodel/music_viewmodel.dart';
import 'package:music_player/app/widgets/music_item.dart';
import 'package:music_player/app/widgets/miniplayer.dart';
import 'package:music_player/app/routes.dart';
import 'package:go_router/go_router.dart';

class MusicScreen extends StatefulWidget {
  final MusicViewmodel musicViewmodel;

  const MusicScreen({
    super.key,
    required this.musicViewmodel,
  });

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  
  @override
  void initState() {
    super.initState();
    widget.musicViewmodel.load();
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.musicViewmodel;
    return Scaffold(
      appBar: AppBar(title: Text('Music Player')),
      body: ListenableBuilder(
        listenable: vm, 
        builder: (context, child) {
          if(!vm.isLoaded){
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: vm.musics.length,
            itemBuilder: (context, index) {
              final music = vm.musics[index];

              return MusicItem(
                name: music.name,
                artist: music.artist,
                duration: music.duration,
                onPressed: () {},
              );
            },
          );

        }
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MiniPlayer(
            isPlaying: false,
            currTime: Duration.zero,
            totalTime: Duration(minutes: 3, seconds: 30),
            onPlayPause: () {},
            onNext: () {},
            onPrevious: () {},
            onTap: () {},
          ),
          BottomNavigationBar(
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) context.go(Routes.player);
              if (index == 2) context.go(Routes.collections);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Currently Playing'),
              BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
              BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
            ],
          )
        ]
      )
    );
  }
}