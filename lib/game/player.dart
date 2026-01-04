import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dino_game.dart';
import 'obstacle.dart';

class Player extends PositionComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  static const double gravity = 1000;
  static const double jumpSpeed = -500;
  static const double groundLevel = 400;

  double velocityY = 0;
  bool isJumping = false;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(40, 40);
    position = Vector2(100, groundLevel);

    // Add collision detection
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Apply gravity
    velocityY += gravity * dt;
    position.y += velocityY * dt;

    // Check if player is on ground
    if (position.y >= groundLevel) {
      position.y = groundLevel;
      velocityY = 0;
      isJumping = false;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw player as a rectangle (dinosaur)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.green,
    );

    // Draw eye
    canvas.drawCircle(
      Offset(size.x * 0.7, size.y * 0.3),
      3,
      Paint()..color = Colors.white,
    );
  }

  void jump() {
    if (!isJumping) {
      velocityY = jumpSpeed;
      isJumping = true;
    }
  }

  void reset() {
    position = Vector2(100, groundLevel);
    velocityY = 0;
    isJumping = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Obstacle) {
      gameRef.gameOver();
    }
  }
}
