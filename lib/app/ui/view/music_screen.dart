import 'package:flutter/material.dart';
import 'package:music_player/app/ui/viewmodel/music_viewmodel.dart';
import 'package:music_player/app/widgets/music_item.dart';

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
    );
  }
}