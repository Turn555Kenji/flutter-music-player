import 'package:flutter/material.dart';
import 'package:music_player/app/routes.dart';
import 'package:go_router/go_router.dart';

class PlayerScreen extends StatelessWidget {

  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Song Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Artist Name',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 32),

            LinearProgressIndicator(value: 0.4),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1:20'),
                Text('3:30'),
              ],
            ),
            SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 36),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.pause, size: 48),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 36),
                  onPressed: () {},
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
}