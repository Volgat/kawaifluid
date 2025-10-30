import 'dart:math' as math;
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const KawaiFluidApp());
}

class KawaiFluidApp extends StatefulWidget {
  const KawaiFluidApp({super.key});

  @override
  State<KawaiFluidApp> createState() => _KawaiFluidAppState();
}

class _KawaiFluidAppState extends State<KawaiFluidApp> {
  FluidTheme _currentTheme = FluidTheme.kawaii;
  late KawaiFluidGame _game;

  @override
  void initState() {
    super.initState();
    _game = KawaiFluidGame(theme: _currentTheme);
  }

  void _changeTheme(FluidTheme newTheme) {
    setState(() {
      _currentTheme = newTheme;
      _game = KawaiFluidGame(theme: _currentTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: _currentTheme.backgroundColor,
        body: Stack(
          children: [
            GameWidget(game: _game),
            Positioned(
              top: 50,
              right: 20,
              child: Column(
                children: [
                  _buildThemeButton('🌸 Kawaii', FluidTheme.kawaii),
                  const SizedBox(height: 10),
                  _buildThemeButton('🌊 Ocean', FluidTheme.ocean),
                  const SizedBox(height: 10),
                  _buildThemeButton('🔥 Fire', FluidTheme.fire),
                  const SizedBox(height: 10),
                  _buildThemeButton('🌌 Galaxy', FluidTheme.galaxy),
                  const SizedBox(height: 10),
                  _buildThemeButton('🍬 Candy', FluidTheme.candy),
                  const SizedBox(height: 10),
                  _buildThemeButton('👻 Neon', FluidTheme.neon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton(String label, FluidTheme theme) {
    final isSelected = _currentTheme == theme;
    return ElevatedButton(
      onPressed: () => _changeTheme(theme),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? theme.colors.first : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

enum FluidTheme {
  kawaii,
  ocean,
  fire,
  galaxy,
  candy,
  neon;

  List<Color> get colors {
    switch (this) {
      case FluidTheme.kawaii:
        return [
          const Color(0xFFa7d7c5), // Pastel Mint
          const Color(0xFFf7a8b8), // Pastel Pink
          const Color(0xFFc9b7db), // Pastel Purple
          const Color(0xFFf5d491), // Pastel Yellow
          const Color(0xFFa1cde3), // Pastel Blue
        ];
      case FluidTheme.ocean:
        return [
          const Color(0xFF006994), // Deep Blue
          const Color(0xFF0099CC), // Ocean Blue
          const Color(0xFF66CCCC), // Turquoise
          const Color(0xFF99CCFF), // Light Blue
          const Color(0xFFCCE5FF), // Pale Blue
        ];
      case FluidTheme.fire:
        return [
          const Color(0xFFFF0000), // Red
          const Color(0xFFFF6600), // Orange
          const Color(0xFFFF9900), // Light Orange
          const Color(0xFFFFCC00), // Yellow-Orange
          const Color(0xFFFFFF00), // Yellow
        ];
      case FluidTheme.galaxy:
        return [
          const Color(0xFF1a0033), // Deep Purple
          const Color(0xFF330066), // Dark Purple
          const Color(0xFF660099), // Purple
          const Color(0xFF9933CC), // Light Purple
          const Color(0xFFCC66FF), // Violet
        ];
      case FluidTheme.candy:
        return [
          const Color(0xFFFF69B4), // Hot Pink
          const Color(0xFFFF1493), // Deep Pink
          const Color(0xFFFF6EC7), // Pink
          const Color(0xFFFFB6C1), // Light Pink
          const Color(0xFFFFC0CB), // Baby Pink
        ];
      case FluidTheme.neon:
        return [
          const Color(0xFF00FF00), // Neon Green
          const Color(0xFF00FFFF), // Cyan
          const Color(0xFFFF00FF), // Magenta
          const Color(0xFFFFFF00), // Yellow
          const Color(0xFFFF0080), // Hot Pink
        ];
    }
  }

  Color get backgroundColor {
    switch (this) {
      case FluidTheme.kawaii:
        return const Color(0xFFFFF8F0);
      case FluidTheme.ocean:
        return const Color(0xFF001a33);
      case FluidTheme.fire:
        return const Color(0xFF1a0000);
      case FluidTheme.galaxy:
        return const Color(0xFF0a0014);
      case FluidTheme.candy:
        return const Color(0xFFFFE4E1);
      case FluidTheme.neon:
        return const Color(0xFF000000);
    }
  }

  double get gravity {
    switch (this) {
      case FluidTheme.kawaii:
        return 10.0;
      case FluidTheme.ocean:
        return 5.0; // Plus lent (effet sous-marin)
      case FluidTheme.fire:
        return 15.0; // Plus rapide
      case FluidTheme.galaxy:
        return 3.0; // Très lent (espace)
      case FluidTheme.candy:
        return 8.0;
      case FluidTheme.neon:
        return 12.0;
    }
  }

  double get restitution {
    switch (this) {
      case FluidTheme.kawaii:
        return 0.8;
      case FluidTheme.ocean:
        return 0.3; // Moins de rebond
      case FluidTheme.fire:
        return 0.9; // Très rebondissant
      case FluidTheme.galaxy:
        return 0.95; // Super rebondissant
      case FluidTheme.candy:
        return 0.85;
      case FluidTheme.neon:
        return 0.9;
    }
  }

  double get impulseStrength {
    switch (this) {
      case FluidTheme.kawaii:
        return 50.0;
      case FluidTheme.ocean:
        return 30.0; // Plus doux
      case FluidTheme.fire:
        return 80.0; // Explosif
      case FluidTheme.galaxy:
        return 40.0;
      case FluidTheme.candy:
        return 60.0;
      case FluidTheme.neon:
        return 70.0;
    }
  }

  int get particleCount {
    switch (this) {
      case FluidTheme.kawaii:
        return 100;
      case FluidTheme.ocean:
        return 80;
      case FluidTheme.fire:
        return 120;
      case FluidTheme.galaxy:
        return 150;
      case FluidTheme.candy:
        return 90;
      case FluidTheme.neon:
        return 100;
    }
  }

  double get ballSize {
    switch (this) {
      case FluidTheme.kawaii:
        return 0.8;
      case FluidTheme.ocean:
        return 0.9; // Plus grosses bulles
      case FluidTheme.fire:
        return 0.6; // Petites flammes
      case FluidTheme.galaxy:
        return 0.5; // Petites étoiles
      case FluidTheme.candy:
        return 0.7;
      case FluidTheme.neon:
        return 0.75;
    }
  }
}

class KawaiFluidGame extends Forge2DGame with TapCallbacks {
  static final math.Random _random = math.Random();
  final FluidTheme theme;

  KawaiFluidGame({required this.theme})
      : super(gravity: Vector2(0, theme.gravity), zoom: 20);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
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
    final screenRect = camera.visibleWorldRect;
    for (var i = 0; i < theme.particleCount; i++) {
      final position = Vector2(
        _random.nextDouble() * screenRect.width + screenRect.left,
        _random.nextDouble() * screenRect.height * 0.5 + screenRect.top,
      );
      final color = theme.colors[_random.nextInt(theme.colors.length)];
      add(Ball(
        position: position,
        color: color,
        radius: theme.ballSize,
        restitution: theme.restitution,
      ));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    final worldPos = screenToWorld(event.localPosition);
    _applyImpulseAt(worldPos);
  }

  void _applyImpulseAt(Vector2 worldPosition) {
    final aabb = AABB()
      ..lowerBound.setFrom(worldPosition - Vector2.all(0.5))
      ..upperBound.setFrom(worldPosition + Vector2.all(0.5));

    final callback = BallQueryCallback(worldPosition, theme);
    world.queryAABB(callback, aabb);
  }
}

class BallQueryCallback extends QueryCallback {
  final Vector2 worldPosition;
  final FluidTheme theme;
  static final math.Random _random = math.Random();

  BallQueryCallback(this.worldPosition, this.theme);

  @override
  bool reportFixture(Fixture fixture) {
    final body = fixture.body;
    if (body.bodyType == BodyType.dynamic) {
      final angle = _random.nextDouble() * math.pi * 2;
      final impulse = Vector2(
        math.cos(angle) * body.mass * theme.impulseStrength * 0.3,
        -body.mass * theme.impulseStrength,
      );
      body.applyLinearImpulse(impulse);
      body.setAwake(true);
    }
    return true;
  }
}

class Ball extends BodyComponent {
  final Vector2 position;
  final Color color;
  final double radius;
  final double restitution;

  Ball({
    required this.position,
    required this.color,
    required this.radius,
    required this.restitution,
  });

  @override
  void onMount() {
    super.onMount();
    paint.color = color;
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(
      shape,
      restitution: restitution,
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
