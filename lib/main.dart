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
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildThemeButton('🌸', FluidTheme.kawaii),
                  const SizedBox(height: 8),
                  _buildThemeButton('🌊', FluidTheme.ocean),
                  const SizedBox(height: 8),
                  _buildThemeButton('🔥', FluidTheme.fire),
                  const SizedBox(height: 8),
                  _buildThemeButton('🌌', FluidTheme.galaxy),
                  const SizedBox(height: 8),
                  _buildThemeButton('🍬', FluidTheme.candy),
                  const SizedBox(height: 8),
                  _buildThemeButton('👻', FluidTheme.neon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton(String emoji, FluidTheme theme) {
    final isSelected = _currentTheme == theme;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.white.withAlpha(178),
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? theme.colors.first : Colors.transparent,
          width: 3,
        ),
      ),
      child: IconButton(
        onPressed: () => _changeTheme(theme),
        icon: Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
        padding: EdgeInsets.zero,
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
          const Color(0xFFa7d7c5),
          const Color(0xFFf7a8b8),
          const Color(0xFFc9b7db),
          const Color(0xFFf5d491),
          const Color(0xFFa1cde3),
        ];
      case FluidTheme.ocean:
        return [
          const Color(0xFF006994),
          const Color(0xFF0099CC),
          const Color(0xFF66CCCC),
          const Color(0xFF99CCFF),
          const Color(0xFFCCE5FF),
        ];
      case FluidTheme.fire:
        return [
          const Color(0xFFFF0000),
          const Color(0xFFFF6600),
          const Color(0xFFFF9900),
          const Color(0xFFFFCC00),
          const Color(0xFFFFFF00),
        ];
      case FluidTheme.galaxy:
        return [
          const Color(0xFF1a0033),
          const Color(0xFF330066),
          const Color(0xFF660099),
          const Color(0xFF9933CC),
          const Color(0xFFCC66FF),
        ];
      case FluidTheme.candy:
        return [
          const Color(0xFFFF69B4),
          const Color(0xFFFF1493),
          const Color(0xFFFF6EC7),
          const Color(0xFFFFB6C1),
          const Color(0xFFFFC0CB),
        ];
      case FluidTheme.neon:
        return [
          const Color(0xFF00FF00),
          const Color(0xFF00FFFF),
          const Color(0xFFFF00FF),
          const Color(0xFFFFFF00),
          const Color(0xFFFF0080),
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
        return 15.0;
      case FluidTheme.ocean:
        return 8.0;
      case FluidTheme.fire:
        return 20.0;
      case FluidTheme.galaxy:
        return 5.0;
      case FluidTheme.candy:
        return 12.0;
      case FluidTheme.neon:
        return 18.0;
    }
  }

  double get restitution {
    switch (this) {
      case FluidTheme.kawaii:
        return 0.6;
      case FluidTheme.ocean:
        return 0.2;
      case FluidTheme.fire:
        return 0.8;
      case FluidTheme.galaxy:
        return 0.9;
      case FluidTheme.candy:
        return 0.7;
      case FluidTheme.neon:
        return 0.75;
    }
  }

  double get impulseStrength {
    switch (this) {
      case FluidTheme.kawaii:
        return 100.0;
      case FluidTheme.ocean:
        return 60.0;
      case FluidTheme.fire:
        return 150.0;
      case FluidTheme.galaxy:
        return 80.0;
      case FluidTheme.candy:
        return 120.0;
      case FluidTheme.neon:
        return 140.0;
    }
  }

  int get particleCount {
    switch (this) {
      case FluidTheme.kawaii:
        return 300;
      case FluidTheme.ocean:
        return 250;
      case FluidTheme.fire:
        return 350;
      case FluidTheme.galaxy:
        return 400;
      case FluidTheme.candy:
        return 280;
      case FluidTheme.neon:
        return 320;
    }
  }

  double get ballSize {
    switch (this) {
      case FluidTheme.kawaii:
        return 1.2;
      case FluidTheme.ocean:
        return 1.4;
      case FluidTheme.fire:
        return 0.9;
      case FluidTheme.galaxy:
        return 0.8;
      case FluidTheme.candy:
        return 1.1;
      case FluidTheme.neon:
        return 1.0;
    }
  }
}

class KawaiFluidGame extends Forge2DGame with TapCallbacks {
  static final math.Random _random = math.Random();
  final FluidTheme theme;

  KawaiFluidGame({required this.theme})
      : super(
          gravity: Vector2(0, theme.gravity),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    await Future.delayed(const Duration(milliseconds: 100));
    
    final screenSize = camera.viewport.virtualSize;
    final worldWidth = screenSize.x / 10;
    final worldHeight = screenSize.y / 10;
    
    camera.viewfinder.zoom = 10;
    camera.viewfinder.position = Vector2(worldWidth / 2, worldHeight / 2);
    
    _createBoundaries(worldWidth, worldHeight);
    _createFluidParticles(worldWidth, worldHeight);
  }

  void _createBoundaries(double width, double height) {
    final vertices = <Vector2>[
      Vector2(0, 0),
      Vector2(width, 0),
      Vector2(width, height),
      Vector2(0, height),
    ];

    final chain = ChainShape()..createLoop(vertices);
    final fixtureDef = FixtureDef(chain, friction: 0.2);
    world.createBody(BodyDef()..type = BodyType.static).createFixture(fixtureDef);
  }

  void _createFluidParticles(double width, double height) {
    for (var i = 0; i < theme.particleCount; i++) {
      final position = Vector2(
        _random.nextDouble() * width,
        _random.nextDouble() * height,
      );
      final color = theme.colors[_random.nextInt(theme.colors.length)];
      add(FluidParticle(
        initialPosition: position,
        color: color,
        radius: theme.ballSize,
        restitution: theme.restitution,
      ));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    final worldPos = camera.globalToLocal(event.localPosition);
    _applyFluidImpulse(worldPos);
  }

  void _applyFluidImpulse(Vector2 worldPosition) {
    const radius = 8.0;
    final aabb = AABB()
      ..lowerBound.setFrom(worldPosition - Vector2.all(radius))
      ..upperBound.setFrom(worldPosition + Vector2.all(radius));

    world.queryAABB(FluidParticleQueryCallback(worldPosition, theme), aabb);
  }
}

class FluidParticleQueryCallback extends QueryCallback {
  final Vector2 worldPosition;
  final FluidTheme theme;

  FluidParticleQueryCallback(this.worldPosition, this.theme);

  @override
  bool reportFixture(Fixture fixture) {
    final body = fixture.body;
    if (body.bodyType == BodyType.dynamic) {
      final direction = body.position - worldPosition;
      final distance = direction.length;
      
      if (distance < 8.0 && distance > 0.1) {
        direction.normalize();
        final forceMagnitude = (8.0 - distance) / 8.0 * theme.impulseStrength;
        final impulse = direction * body.mass * forceMagnitude;
        body.applyLinearImpulse(impulse);
        body.setAwake(true);
      }
    }
    return true;
  }
}

class FluidParticle extends BodyComponent {
  final Vector2 initialPosition;
  final Color color;
  final double radius;
  final double restitution;

  FluidParticle({
    required this.initialPosition,
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
      friction: 0.3,
    );
    final bodyDef = BodyDef(
      userData: this,
      position: initialPosition,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
