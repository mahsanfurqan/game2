import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/star_catcher_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Catcher Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(body: GameWidget(game: StarCatcherGame())),
    );
  }
}
