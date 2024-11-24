import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jump_run_game/my_game.dart';
import 'package:jump_run_game/platforms/goal.dart';
import 'package:jump_run_game/platforms/ground.dart';
import 'package:jump_run_game/platforms/platform.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<MyGame>, KeyboardHandler, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  final gravity = 400;

  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;

  @override
  Future<void> onLoad() async {
    size = Vector2(100, 100);
    idleAnimation = await game.loadSpriteAnimation(
      'Idle.png',
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.5,
        textureSize: Vector2(512, 512),
      ),
    );

    runAnimation = await game.loadSpriteAnimation(
      'Run.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(512, 512),
      ),
    );

    jumpAnimation = await game.loadSpriteAnimation(
      'Jump.png',
      SpriteAnimationData.sequenced(
        amount: 11,
        stepTime: 0.1,
        textureSize: Vector2(512, 512),
      ),
    );

    animation = idleAnimation;
    anchor = Anchor.center;

    add(RectangleHitbox(
      position: Vector2(20, 10),
      size: Vector2(60, 90),
    ));
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    velocity = Vector2.zero();

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) velocity.x = -200;
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) velocity.x = 200;
    if (keysPressed.contains(LogicalKeyboardKey.space)) jump();
    return super.onKeyEvent(event, keysPressed);
  }

  void jump() {
    if (isOnGround) {
      velocity.y = -600;
      isOnGround = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isOnGround) {
      velocity.y += gravity * dt;
    }

    position += velocity * dt;

    if (!isOnGround) {
      animation = jumpAnimation;
    } else if (velocity.x != 0) {
      if (velocity.x > 0 && scale.x < 0) {
        flipHorizontallyAroundCenter();
      } else if (velocity.x < 0 && scale.x > 0) {
        flipHorizontallyAroundCenter();
      }
      animation = runAnimation;
    } else {
      animation = idleAnimation;
    }

    position.clamp(
      Vector2.zero(),
      Vector2(
        MyGame.baseResolution.x - size.x,
        MyGame.baseResolution.y - size.y,
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Platform || other is Ground || other is Goal) {
      if (velocity.y > 0) {
        velocity.y = 0;
        isOnGround = true;
        position.y = other.position.y - size.y / 2;
      }

      if (other is Goal) {
        debugPrint('Nivel Completado!!');
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Platform || other is Ground || other is Goal) {
      isOnGround = false;
    }
  }
}
