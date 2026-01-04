import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dino_game.dart';

class Obstacle extends PositionComponent with HasGameRef<DinoGame> {
  static const double speed = 200;
  static const double groundLevel = 400;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(30, 50);
    position = Vector2(gameRef.size.x, groundLevel - size.y);

    // Add collision detection
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move obstacle to the left
    position.x -= speed * dt;

    // Remove obstacle when it goes off screen
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw obstacle as a cactus (rectangle)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.red,
    );
  }
}
