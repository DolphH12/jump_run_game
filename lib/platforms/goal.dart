import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Goal extends PositionComponent with CollisionCallbacks {
  Goal({super.size, super.position});

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.yellow;
    canvas.drawRect(size.toRect(), paint);
  }

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
  }
}
