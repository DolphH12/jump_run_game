import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:jump_run_game/my_game.dart';

class Ground extends PositionComponent with CollisionCallbacks {
  Ground({super.size});

  @override
  FutureOr<void> onLoad() {
    position = Vector2(0, MyGame.baseResolution.y - size.y);

    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.green;
    canvas.drawRect(size.toRect(), paint);
  }
}
