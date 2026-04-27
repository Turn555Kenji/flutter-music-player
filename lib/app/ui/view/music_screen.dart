import 'package:flutter/material.dart';
import 'package:music_player/app/ui/viewmodel/music_viewmodel.dart';

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

          return Text("test");
        }
      ),
    );
  }
}