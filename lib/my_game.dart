import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:jump_run_game/level/level.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  static Vector2 baseResolution = Vector2(800, 600);
  @override
  Future<void> onLoad() async {
    final worldLevel = Level();

    final cam = CameraComponent.withFixedResolution(
      world: worldLevel,
      width: baseResolution.x,
      height: baseResolution.y,
    );

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, worldLevel]);
  }
}
