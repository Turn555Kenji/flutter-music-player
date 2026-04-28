import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:music_player/app/ui/viewmodel/music_viewmodel.dart';
import 'package:music_player/app/ui/viewmodel/playlist_viewmodel.dart';

class CreatePlaylistScreen extends StatefulWidget {
  final MusicViewmodel musicViewmodel;
  final PlaylistViewmodel playlistViewmodel;

  const CreatePlaylistScreen({
    super.key,
    required this.musicViewmodel,
    required this.playlistViewmodel,
  });

  @override
  State<CreatePlaylistScreen> createState() => _CreatePlaylistScreenState();
}

class _CreatePlaylistScreenState extends State<CreatePlaylistScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();
  final List<Music> selectedMusic = [];

  @override
  void initState() {
    super.initState();
    widget.musicViewmodel.load();
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }

  void toggleSong(Music song) {
    setState(() {
      if (selectedMusic.any((s) => s.id == song.id)) {
        selectedMusic.removeWhere((s) => s.id == song.id);
      } else {
        selectedMusic.add(song);
      }
    });
  }

  void save() {
    if (formKey.currentState!.validate()) {
      widget.playlistViewmodel.createPlaylist(
        name.text,
        selectedMusic,
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.musicViewmodel;
    return Scaffold(

      appBar: AppBar(
        title: Text('Create Playlist'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: save,
            child: Text('Save'),
          ),
        ],
      ),

      body: Form(
        key: formKey,
        child: ListenableBuilder(
          listenable: vm, 
          builder: (context, child) {
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey,
                      child: Icon(Icons.add_a_photo, size: 40),
                    ),
                  )  
                ),

                SizedBox(height: 24),

                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => null, // optional
                ),

                SizedBox(height: 24),

                Text(
                  'Add Songs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                if (!vm.isLoaded)
                  Center(child: CircularProgressIndicator())
                else
                  ...vm.musics.map((music) {
                    final isSelected =
                        selectedMusic.any((s) => s.id == music.id);
                    return CheckboxListTile(
                      title: Text(music.name),
                      subtitle: Text(music.artist),
                      value: isSelected,
                      onChanged: (_) => toggleSong(music),
                    );
                  }),
              ],
            );
          }
        )
      )

    );
  }
}