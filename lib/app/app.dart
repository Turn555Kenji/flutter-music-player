import 'package:flutter/material.dart';
import 'package:music_player/app/providers.dart';
import 'package:music_player/app/ui/view/music_screen.dart';
import 'package:music_player/app/ui/view/collection_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      ///
      ///
      ///
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Music Player',
            debugShowCheckedModeBanner: false,
            /*home: MusicScreen(
              musicViewmodel: context.read(),
            ),*/
            home: CollectionScreen(
              albumViewmodel: context.read(),
              playlistViewmodel: context.read(),
            ),
          //routerConfig: routes,
          );
        },
      ),
      ///
      ///
      ///
    );
  }
}
