import 'package:flutter/material.dart';
import 'package:music_player/app/providers.dart';
import 'package:provider/provider.dart';
import 'package:music_player/app/routes.dart';

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
          return MaterialApp.router(
            title: 'Music Player',
            debugShowCheckedModeBanner: false,
            routerConfig: routes,
          );
        },
      ),
      ///
      ///
      ///
    );
  }
}
