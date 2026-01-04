import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'obstacle.dart';
import 'ground.dart';

class DinoGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Player player;
  late Ground ground;
  double obstacleSpawnTimer = 0;
  double obstacleSpawnInterval = 2.0;
  int score = 0;
  bool isGameOver = false;

  @override
  FutureOr<void> onLoad() async {
    // Add ground
    ground = Ground();
    add(ground);

    // Add player
    player = Player();
    add(player);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isGameOver) return;

    // Update score
    score += (dt * 10).toInt();

    // Spawn obstacles
    obstacleSpawnTimer += dt;
    if (obstacleSpawnTimer >= obstacleSpawnInterval) {
      obstacleSpawnTimer = 0;
      add(Obstacle());

      // Increase difficulty over time
      if (obstacleSpawnInterval > 1.0) {
        obstacleSpawnInterval -= 0.01;
      }
    }
  }

  @override
  void onTap() {
    if (!isGameOver) {
      player.jump();
    } else {
      // Restart game
      resetGame();
    }
  }

  void gameOver() {
    isGameOver = true;
    pauseEngine();
  }

  void resetGame() {
    isGameOver = false;
    score = 0;
    obstacleSpawnInterval = 2.0;
    obstacleSpawnTimer = 0;

    // Remove all obstacles
    children.whereType<Obstacle>().forEach((obstacle) {
      obstacle.removeFromParent();
    });

    // Reset player
    player.reset();
    resumeEngine();
  }

  @override
  void render(Canvas canvas) {
    // Draw sky background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = const Color(0xFF87CEEB),
    );

    super.render(canvas);

    // Draw score
    final textPaint = TextPaint(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
    textPaint.render(canvas, 'Score: $score', Vector2(20, 20));

    // Draw game over text
    if (isGameOver) {
      final gameOverPaint = TextPaint(
        style: const TextStyle(
          color: Colors.red,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      );
      gameOverPaint.render(
        canvas,
        'GAME OVER',
        Vector2(size.x / 2 - 150, size.y / 2 - 50),
      );

      final restartPaint = TextPaint(
        style: const TextStyle(color: Colors.black, fontSize: 24),
      );
      restartPaint.render(
        canvas,
        'Tap to restart',
        Vector2(size.x / 2 - 80, size.y / 2 + 20),
      );
    }
  }
}
