import 'package:flutter/material.dart';
import 'package:music_player/app/ui/viewmodel/album_viewmodel.dart';
import 'package:music_player/app/ui/viewmodel/playlist_viewmodel.dart';
import 'package:music_player/app/widgets/playlist_item.dart';

class CollectionScreen extends StatefulWidget {
  final AlbumViewmodel albumViewmodel;
  final PlaylistViewmodel playlistViewmodel;

  const CollectionScreen({
    super.key,
    required this.albumViewmodel,
    required this.playlistViewmodel
  });

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  
  @override
  void initState() {
    super.initState();
    widget.albumViewmodel.load();
    widget.playlistViewmodel.load();
  }

  @override
  Widget build(BuildContext context) {
    final avm = widget.albumViewmodel;
    final plvm = widget.playlistViewmodel;

    return Scaffold(
      appBar: AppBar(title: Text('Playlists')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([avm, plvm]) ,
        builder: (context, child) {
          if(!avm.isLoaded || !plvm.isLoaded){
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              Text('Albums'),
              ...avm.albums.map((album) => PlaylistItem(
                name: album.name,
                coverUrl: album.coverUrl,
                details: album.artist,
                onPressed: () {},
              )),

              Divider(),

              Text('Playlists'),
              ...plvm.playlists.map((playlist) => PlaylistItem(
                name: playlist.name,
                coverUrl: playlist.coverUrl ?? " ",
                details: '${playlist.musicList.length} items',
                onPressed: () {},
              ))
            ],
          );

        }
      ),
    );
  }
}