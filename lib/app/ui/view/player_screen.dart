import 'package:flutter/material.dart';
import 'package:music_player/app/routes.dart';
import 'package:music_player/app/data/models/music.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/app/ui/viewmodel/player_viewmodel.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:music_player/app/ui/viewmodel/lyrics_viewmodel.dart';
import 'package:music_player/app/data/services/lyrics_service.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  late PlayerViewmodel _playerVm; // ← add this

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _playerVm = context.read<PlayerViewmodel>();
    final lyricsVm = context.read<LyricsViewmodel>();

    _playerVm.onMusicChanged = (music) {
      if (!mounted) return;
      _searchController.text = lyricsVm.buildQuery(music);
      lyricsVm.loadForMusic(music);
    };

    WidgetsBinding.instance.addPostFrameCallback((_) { // ← wrap in this
      if (_playerVm.currentMusic != null) {
        _searchController.text = lyricsVm.buildQuery(_playerVm.currentMusic!);
        lyricsVm.loadForMusic(_playerVm.currentMusic!);
      }
    });
  }

  @override
  void dispose() {
    _playerVm.onMusicChanged = null; // ← use saved reference, no context.read()
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: context.watch<PlayerViewmodel>(),
      builder: (context, child) {
        final playerVm = context.read<PlayerViewmodel>();
        final music = playerVm.currentMusic;

        return Scaffold(
          appBar: AppBar(
            title: Text('Now Playing'),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Player'),
                Tab(text: 'Lyrics'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: music?.coverUrl != null && music!.coverUrl!.isNotEmpty
                          ? Image.file(File(music.coverUrl!), width: 300, height: 300, fit: BoxFit.cover)
                          : Container(width: 300, height: 300, color: Colors.grey, child: Icon(Icons.music_note, size: 100)),
                    ),
                    SizedBox(height: 32),
                    Text(music?.name ?? 'No music selected', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(music?.artist ?? '', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    SizedBox(height: 32),
                    Slider(
                      value: playerVm.currDuration.inSeconds.toDouble().clamp(0, playerVm.totalDuration.inSeconds.toDouble()),
                      max: playerVm.totalDuration.inSeconds.toDouble() == 0 ? 1 : playerVm.totalDuration.inSeconds.toDouble(),
                      onChanged: (value) => playerVm.seek(Duration(seconds: value.toInt())),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(playerVm.currDuration)),
                          Text(_formatDuration(playerVm.totalDuration)),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(icon: Icon(Icons.skip_previous, size: 36), onPressed: () => playerVm.previous()),
                        IconButton(icon: Icon(playerVm.isPlaying ? Icons.pause : Icons.play_arrow, size: 48), onPressed: () => playerVm.togglePlayPause()),
                        IconButton(icon: Icon(Icons.skip_next, size: 36), onPressed: () => playerVm.next()),
                      ],
                    ),
                  ],
                ),
              ),

              // lyric
              ListenableBuilder(
                listenable: context.watch<LyricsViewmodel>(),
                builder: (context, child) {
                  final lyricsVm = context.read<LyricsViewmodel>();

                  return Column(
                    children: [
                      // search bar
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search lyrics manually...',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                onSubmitted: (q) => lyricsVm.search(q),
                              ),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () => lyricsVm.search(_searchController.text),
                            ),
                          ],
                        ),
                      ),

                      // search result
                      if (lyricsVm.isSearching)
                        LinearProgressIndicator()
                      else if (lyricsVm.searchResults.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            itemCount: lyricsVm.searchResults.length,
                            itemBuilder: (context, index) {
                              final result = lyricsVm.searchResults[index];
                              return ListTile(
                                title: Text(result.trackName),
                                subtitle: Text('${result.artistName} — ${result.albumName}'),
                                trailing: Text('${result.duration.toInt()}s'),
                                onTap: () {
                                  lyricsVm.selectResult(result);
                                  _searchController.clear();
                                },
                              );
                            },
                          ),
                        )
                      // lyrics display
                      else if (lyricsVm.isLoading)
                        Expanded(child: Center(child: CircularProgressIndicator()))
                      else if (lyricsVm.current?.plainLyrics != null)
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              lyricsVm.current!.plainLyrics!,
                              style: TextStyle(fontSize: 16, height: 1.8),
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lyrics_outlined, size: 48, color: Colors.grey),
                                SizedBox(height: 12),
                                Text(lyricsVm.error ?? 'No lyrics', style: TextStyle(color: Colors.grey)),
                                SizedBox(height: 12),
                                TextButton(
                                  onPressed: () {
                                    if (music != null) {
                                      _searchController.text = '${music.artist} ${music.name}';
                                      lyricsVm.search(_searchController.text);
                                    }
                                  },
                                  child: Text('Search manually'),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
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
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}