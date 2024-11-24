import 'dart:async';

import 'package:flame/components.dart';
import 'package:jump_run_game/my_game.dart';

class Background extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Background.jpg');
    size = MyGame.baseResolution;
  }
}
