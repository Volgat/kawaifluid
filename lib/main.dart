
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: KawaiFluidGame()));
}

class KawaiFluidGame extends Forge2DGame with DragCallbacks, TapCallbacks {
  static final math.Random _random = math.Random();
  final List<Color> _kawaiiColors = [
    const Color(0xFFa7d7c5), // Pastel Mint
    const Color(0xFFf7a8b8), // Pastel Pink
    const Color(0xFFc9b7db), // Pastel Purple
    const Color(0xFFf5d491), // Pastel Yellow
    const Color(0xFFa1cde3), // Pastel Blue
  ];

  MouseJoint? _mouseJoint;
  late final Body _groundBody;

  KawaiFluidGame() : super(gravity: Vector2(0, 10.0), zoom: 20);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _groundBody = world.createBody(BodyDef());
    _createBoundaries();
    _createBalls();
  }

  void _createBoundaries() {
    final screenRect = camera.visibleWorldRect;
    final vertices = <Vector2>[
      Vector2(screenRect.left, screenRect.top),
      Vector2(screenRect.right, screenRect.top),
      Vector2(screenRect.right, screenRect.bottom),
      Vector2(screenRect.left, screenRect.bottom),
    ];

    final chain = ChainShape()..createLoop(vertices);
    final fixtureDef = FixtureDef(chain, friction: 0.3);
    world.createBody(BodyDef()..type = BodyType.static).createFixture(fixtureDef);
  }

  void _createBalls() {
    const int ballCount = 100;
    final screenRect = camera.visibleWorldRect;
    for (var i = 0; i < ballCount; i++) {
      final position = Vector2(
        _random.nextDouble() * screenRect.width + screenRect.left,
        _random.nextDouble() * screenRect.height * 0.5 + screenRect.top,
      );
      final color = _kawaiiColors[_random.nextInt(_kawaiiColors.length)];
      add(Ball(position: position, color: color));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (_mouseJoint == null) {
      _createQuery(screenToWorld(event.localPosition));
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (_mouseJoint == null) {
      _createQuery(screenToWorld(event.localPosition));
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    _mouseJoint?.setTarget(screenToWorld(event.localPosition));
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _destroyMouseJoint();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _destroyMouseJoint();
  }

  void _createQuery(Vector2 worldPosition) {
    final aabb = AABB()
      ..lowerBound.setFrom(worldPosition - Vector2.all(0.001))
      ..upperBound.setFrom(worldPosition + Vector2.all(0.001));

    world.queryAABB(aabb, (fixture) {
      final body = fixture.body;
      if (body.type == BodyType.dynamic) {
        final mouseJointDef = MouseJointDef()
          ..bodyA = _groundBody
          ..bodyB = body
          ..target.setFrom(worldPosition)
          ..maxForce = body.mass * 1000
          ..frequencyHz = 5.0
          ..dampingRatio = 0.9;
        _mouseJoint = world.createJoint(mouseJointDef) as MouseJoint;
        body.setAwake(true);
        return false;
      }
      return true;
    });
  }

  void _destroyMouseJoint() {
    if (_mouseJoint != null) {
      world.destroyJoint(_mouseJoint!);
      _mouseJoint = null;
    }
  }
}

class Ball extends BodyComponent {
  final Vector2 position;
  final Color color;

  Ball({required this.position, required this.color});

  @override
  void onMount() {
    super.onMount();
    paint.color = color;
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 0.8;
    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      density: 1.0,
      friction: 0.4,
    );
    final bodyDef = BodyDef(
      userData: this,
      position: position,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
