import 'dart:async';

import 'package:flame/components.dart';
import 'package:jump_run_game/background/background.dart';
import 'package:jump_run_game/my_game.dart';
import 'package:jump_run_game/platforms/goal.dart';
import 'package:jump_run_game/platforms/ground.dart';
import 'package:jump_run_game/platforms/platform.dart';
import 'package:jump_run_game/player/player.dart';

class Level extends World {
  @override
  Future<void> onLoad() async {
    add(Background());

    add(Ground(size: Vector2(MyGame.baseResolution.x, 50)));

    add(Player()..position = Vector2(0, MyGame.baseResolution.y - 300));

    add(Platform(size: Vector2(200, 20), position: Vector2(120, 400)));
    add(Platform(size: Vector2(200, 20), position: Vector2(380, 300)));

    add(Goal(
      size: Vector2(50, 20),
      position: Vector2(650, 250),
    ));
  }
}
