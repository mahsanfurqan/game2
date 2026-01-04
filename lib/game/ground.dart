import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dino_game.dart';

class Ground extends PositionComponent with HasGameRef<DinoGame> {
  static const double groundHeight = 450;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(2000, 10);
    position = Vector2(0, groundHeight);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw ground as a line
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.black,
    );
  }
}
