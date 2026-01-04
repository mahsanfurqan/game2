import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'star_catcher_game.dart';

class Basket extends PositionComponent with HasGameRef<StarCatcherGame> {
  static const double speed = 400;
  double direction = 0;
  double targetX = 0;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(100, 80);
    position = Vector2(gameRef.size.x / 2 - size.x / 2, gameRef.size.y - 120);
    targetX = position.x;

    // Add collision detection
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Keyboard movement
    position.x += direction * speed * dt;

    // Mouse/Touch movement
    if ((targetX - position.x).abs() > 5) {
      final diff = targetX - position.x;
      position.x += diff.sign * speed * dt * 2;
    }

    // Keep basket on screen
    if (position.x < 0) position.x = 0;
    if (position.x > gameRef.size.x - size.x) {
      position.x = gameRef.size.x - size.x;
    }

    targetX = position.x;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw basket body
    final bodyPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFFFD700), const Color(0xFFFFA500)],
          ).createShader(Rect.fromLTWH(0, 0, size.x, size.y));

    final basketPath = Path();
    basketPath.moveTo(10, 0);
    basketPath.lineTo(0, size.y);
    basketPath.lineTo(size.x, size.y);
    basketPath.lineTo(size.x - 10, 0);
    basketPath.close();

    canvas.drawPath(basketPath, bodyPaint);

    // Draw basket rim
    canvas.drawLine(
      Offset(10, 0),
      Offset(size.x - 10, 0),
      Paint()
        ..color = const Color(0xFFFFE55C)
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );

    // Draw basket pattern
    for (int i = 1; i < 5; i++) {
      final x = (size.x / 5) * i;
      canvas.drawLine(
        Offset(x - 2, 10),
        Offset(x + 2, size.y - 10),
        Paint()
          ..color = const Color(0xFFFFE55C).withOpacity(0.5)
          ..strokeWidth = 2,
      );
    }
  }

  void moveToX(double x) {
    targetX = x - size.x / 2;
  }

  void reset() {
    position = Vector2(gameRef.size.x / 2 - size.x / 2, gameRef.size.y - 120);
    targetX = position.x;
    direction = 0;
  }
}
