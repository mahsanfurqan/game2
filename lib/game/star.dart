import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'star_catcher_game.dart';
import 'basket.dart';

class Star extends PositionComponent
    with HasGameRef<StarCatcherGame>, CollisionCallbacks {
  static const double fallSpeed = 150;
  final Random random = Random();
  late Color starColor;
  late int points;
  double rotation = 0;
  double rotationSpeed = 0;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(40, 40);

    // Random horizontal position
    position = Vector2(
      random.nextDouble() * (gameRef.size.x - size.x),
      -size.y,
    );

    // Random color and points
    final colorIndex = random.nextInt(3);
    switch (colorIndex) {
      case 0:
        starColor = Colors.yellow;
        points = 10;
        break;
      case 1:
        starColor = Colors.cyan;
        points = 20;
        break;
      case 2:
        starColor = Colors.pink;
        points = 30;
        break;
    }

    // Random rotation speed
    rotationSpeed = (random.nextDouble() - 0.5) * 4;

    // Add collision detection
    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Fall down
    position.y += fallSpeed * dt;

    // Rotate
    rotation += rotationSpeed * dt;

    // Remove if off screen (missed)
    if (position.y > gameRef.size.y) {
      gameRef.missedStar();
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.save();
    canvas.translate(size.x / 2, size.y / 2);
    canvas.rotate(rotation);

    // Draw star with glow effect
    final glowPaint =
        Paint()
          ..color = starColor.withOpacity(0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    _drawStar(canvas, size.x / 2 + 5, glowPaint);

    // Draw main star
    final starPaint =
        Paint()
          ..shader = RadialGradient(
            colors: [Colors.white, starColor],
          ).createShader(
            Rect.fromCircle(center: Offset.zero, radius: size.x / 2),
          );

    _drawStar(canvas, size.x / 2, starPaint);

    // Draw star outline
    _drawStar(
      canvas,
      size.x / 2,
      Paint()
        ..color = Colors.white.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    canvas.restore();
  }

  void _drawStar(Canvas canvas, double radius, Paint paint) {
    final path = Path();
    const numPoints = 5;

    for (int i = 0; i < numPoints * 2; i++) {
      final angle = (i * pi) / numPoints - pi / 2;
      final r = i.isEven ? radius : radius * 0.5;
      final x = cos(angle) * r;
      final y = sin(angle) * r;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Basket) {
      gameRef.collectStar(this, points);
    }
  }
}
