import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'basket.dart';
import 'star.dart';
import 'particle_effect.dart';

class StarCatcherGame extends FlameGame
    with KeyboardEvents, TapDetector, HasCollisionDetection {
  late Basket basket;
  double starSpawnTimer = 0;
  double starSpawnInterval = 1.5;
  int score = 0;
  int lives = 3;
  bool isGameOver = false;
  final Random random = Random();

  @override
  FutureOr<void> onLoad() async {
    // Add basket
    basket = Basket();
    add(basket);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isGameOver) return;

    // Spawn stars
    starSpawnTimer += dt;
    if (starSpawnTimer >= starSpawnInterval) {
      starSpawnTimer = 0;
      add(Star());

      // Increase difficulty
      if (starSpawnInterval > 0.5) {
        starSpawnInterval -= 0.01;
      }
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (!isGameOver) {
      // Move basket to tap position
      basket.moveToX(info.eventPosition.global.x);
    } else {
      resetGame();
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (isGameOver) return KeyEventResult.ignored;

    final isLeft =
        keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRight =
        keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD);

    basket.direction = 0;
    if (isLeft) basket.direction = 1;
    if (isRight) basket.direction = -1;

    return KeyEventResult.handled;
  }

  void collectStar(Star star, int points) {
    score += points;
    star.removeFromParent();

    // Add particle effect
    add(ParticleEffect(position: star.position, color: star.starColor));
  }

  void missedStar() {
    lives--;
    if (lives <= 0) {
      gameOver();
    }
  }

  void gameOver() {
    isGameOver = true;
    pauseEngine();
  }

  void resetGame() {
    isGameOver = false;
    score = 0;
    lives = 3;
    starSpawnInterval = 1.5;
    starSpawnTimer = 0;

    // Remove all stars
    children.whereType<Star>().forEach((star) {
      star.removeFromParent();
    });

    // Remove all particle effects
    children.whereType<ParticleEffect>().forEach((effect) {
      effect.removeFromParent();
    });

    // Reset basket
    basket.reset();
    resumeEngine();
  }

  @override
  void render(Canvas canvas) {
    // Draw gradient background
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF1a0033),
        const Color(0xFF2d1b69),
        const Color(0xFF4a2c8f),
      ],
    );

    final paint =
        Paint()
          ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.x, size.y));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);

    super.render(canvas);

    // Draw UI
    _drawScore(canvas);
    _drawLives(canvas);

    if (isGameOver) {
      _drawGameOver(canvas);
    }
  }

  void _drawScore(Canvas canvas) {
    final textPaint = TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 4),
        ],
      ),
    );
    textPaint.render(canvas, 'Score: $score', Vector2(20, 20));
  }

  void _drawLives(Canvas canvas) {
    const heartSize = 30.0;
    const spacing = 40.0;

    for (int i = 0; i < 3; i++) {
      final x = size.x - (spacing * (3 - i));
      final y = 25.0;

      final paint =
          Paint()
            ..color = i < lives ? Colors.red : Colors.grey.withOpacity(0.3);

      // Draw heart shape
      final path = Path();
      path.moveTo(x, y + heartSize * 0.3);
      path.cubicTo(
        x,
        y,
        x - heartSize * 0.5,
        y,
        x - heartSize * 0.5,
        y + heartSize * 0.3,
      );
      path.cubicTo(
        x - heartSize * 0.5,
        y + heartSize * 0.6,
        x,
        y + heartSize * 0.8,
        x,
        y + heartSize,
      );
      path.cubicTo(
        x,
        y + heartSize * 0.8,
        x + heartSize * 0.5,
        y + heartSize * 0.6,
        x + heartSize * 0.5,
        y + heartSize * 0.3,
      );
      path.cubicTo(x + heartSize * 0.5, y, x, y, x, y + heartSize * 0.3);

      canvas.drawPath(path, paint);
    }
  }

  void _drawGameOver(Canvas canvas) {
    // Draw semi-transparent overlay
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.black.withOpacity(0.7),
    );

    final gameOverPaint = TextPaint(
      style: const TextStyle(
        color: Colors.red,
        fontSize: 64,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(color: Colors.black, offset: Offset(3, 3), blurRadius: 6),
        ],
      ),
    );
    gameOverPaint.render(
      canvas,
      'GAME OVER',
      Vector2(size.x / 2 - 180, size.y / 2 - 100),
    );

    final scorePaint = TextPaint(
      style: const TextStyle(
        color: Colors.yellow,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
    scorePaint.render(
      canvas,
      'Final Score: $score',
      Vector2(size.x / 2 - 120, size.y / 2 - 20),
    );

    final restartPaint = TextPaint(
      style: const TextStyle(color: Colors.white, fontSize: 28),
    );
    restartPaint.render(
      canvas,
      'Tap to restart',
      Vector2(size.x / 2 - 90, size.y / 2 + 40),
    );
  }
}
