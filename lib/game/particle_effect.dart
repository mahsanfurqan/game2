import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'star_catcher_game.dart';

class ParticleEffect extends PositionComponent
    with HasGameRef<StarCatcherGame> {
  final Color color;
  final Random random = Random();
  final List<Particle> particles = [];
  double lifetime = 0;
  static const double maxLifetime = 1.0;

  ParticleEffect({required Vector2 position, required this.color}) {
    this.position = position;
  }

  @override
  FutureOr<void> onLoad() {
    // Create particles
    for (int i = 0; i < 20; i++) {
      particles.add(
        Particle(
          position: Vector2.zero(),
          velocity: Vector2(
            (random.nextDouble() - 0.5) * 300,
            (random.nextDouble() - 0.5) * 300,
          ),
          color: color,
        ),
      );
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    lifetime += dt;

    for (var particle in particles) {
      particle.update(dt);
    }

    if (lifetime >= maxLifetime) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final opacity = (1.0 - (lifetime / maxLifetime)).clamp(0.0, 1.0);

    for (var particle in particles) {
      particle.render(canvas, opacity);
    }
  }
}

class Particle {
  Vector2 position;
  Vector2 velocity;
  Color color;

  Particle({
    required this.position,
    required this.velocity,
    required this.color,
  });

  void update(double dt) {
    position += velocity * dt;
    velocity.y += 500 * dt; // Gravity
  }

  void render(Canvas canvas, double opacity) {
    canvas.drawCircle(
      Offset(position.x, position.y),
      4,
      Paint()
        ..color = color.withOpacity(opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
  }
}
