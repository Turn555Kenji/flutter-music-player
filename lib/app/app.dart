import 'package:flutter/material.dart';
import 'package:music_player/app/providers.dart';
import 'package:provider/provider.dart';
import 'package:music_player/app/routes.dart';
import 'package:music_player/app/ui/viewmodel/login_viewmodel.dart';

class App extends StatefulWidget {
  const App({super.key});
  
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) {
          return FutureBuilder(
            future: context.read<AuthViewmodel>().checkSession(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return MaterialApp(
                  home: Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              return MaterialApp.router(
                title: 'Music Player',
                debugShowCheckedModeBanner: false,
                routerConfig: createRouter(context.read<AuthViewmodel>()),
              );
            },
          );
        },
      ),
    );
  }
}
