import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const KawaiFluidApp(),
    ),
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class KawaiFluidApp extends StatelessWidget {
  const KawaiFluidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFFf7a8b8),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFFf7a8b8),
            useMaterial3: true,
          ),
          themeMode: themeProvider.themeMode,
          home: const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeScreen(),
          ThemesScreen(),
          RelaxationScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.water_drop_outlined),
            selectedIcon: Icon(Icons.water_drop),
            label: 'Themes',
          ),
          NavigationDestination(
            icon: Icon(Icons.spa_outlined),
            selectedIcon: Icon(Icons.spa),
            label: 'Relax',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// HOME SCREEN
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              '🌸 Kawaii Fluid',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFf7a8b8),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'ASMR Relaxation Therapy',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Quick Start
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FluidSimulationScreen(
                      theme: FluidTheme.kawaii,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFf7a8b8), Color(0xFFa7d7c5)],
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.play_circle_filled,
                          size: 48, color: Colors.white),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Fluid ASMR',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Touch the screen to create mesmerizing waves',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'How It Works',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            _buildFeature(
              '👆 Touch Interaction',
              'Touch anywhere to create fluid ripples and waves',
              Icons.touch_app,
            ),
            _buildFeature(
              '🌊 Real-Time Simulation',
              'Advanced shader-based fluid dynamics',
              Icons.waves,
            ),
            _buildFeature(
              '🎨 Beautiful Themes',
              '6 stunning color themes to choose from',
              Icons.palette,
            ),
            _buildFeature(
              '💆 Stress Relief',
              'Scientifically proven to reduce anxiety',
              Icons.spa,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFf7a8b8).withAlpha(51),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFf7a8b8), size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// THEMES SCREEN
class ThemesScreen extends StatelessWidget {
  const ThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fluid Themes',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Choose your favorite color palette',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildThemeCard(context, FluidTheme.kawaii, '🌸 Kawaii',
                    'Soft Pink & Mint', const Color(0xFFf7a8b8)),
                _buildThemeCard(context, FluidTheme.ocean, '🌊 Ocean',
                    'Deep Blue Waves', const Color(0xFF0099CC)),
                _buildThemeCard(context, FluidTheme.fire, '🔥 Fire',
                    'Warm Flames', const Color(0xFFFF6600)),
                _buildThemeCard(context, FluidTheme.galaxy, '🌌 Galaxy',
                    'Cosmic Purple', const Color(0xFF660099)),
                _buildThemeCard(context, FluidTheme.candy, '🍬 Candy',
                    'Sweet Pink', const Color(0xFFFF69B4)),
                _buildThemeCard(context, FluidTheme.sunset, '🌅 Sunset',
                    'Orange & Gold', const Color(0xFFFF8C00)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(BuildContext context, FluidTheme theme, String name,
      String description, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FluidSimulationScreen(theme: theme),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withAlpha(153)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name.split(' ')[0], style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              Text(
                name.split(' ')[1],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// RELAXATION SCREEN
class RelaxationScreen extends StatefulWidget {
  const RelaxationScreen({super.key});

  @override
  State<RelaxationScreen> createState() => _RelaxationScreenState();
}

class _RelaxationScreenState extends State<RelaxationScreen> {
  bool _isBreathing = false;
  int _breathCount = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Relaxation Guide',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Combine fluid visuals with breathing',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(Icons.air, size: 64, color: Color(0xFFa7d7c5)),
                    const SizedBox(height: 16),
                    const Text(
                      'Breathing Exercise',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isBreathing
                          ? 'Breathe in... Hold... Breathe out...'
                          : 'Follow the guided breathing',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    if (_isBreathing)
                      Text(
                        'Breath Count: $_breathCount',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFf7a8b8),
                        ),
                      ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isBreathing = !_isBreathing;
                          if (!_isBreathing) _breathCount = 0;
                        });
                        if (_isBreathing) _startBreathing();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFf7a8b8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: Text(
                        _isBreathing ? 'Stop' : 'Start Exercise',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Quick Tips',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTip('💆 Daily Practice',
                'Use for 5-10 minutes daily for best results'),
            _buildTip('🌙 Before Bed', 'Perfect for winding down before sleep'),
            _buildTip('☕ Break Time', 'Quick stress relief during work breaks'),
            _buildTip(
                '🎧 With Music', 'Add calming music for enhanced relaxation'),
          ],
        ),
      ),
    );
  }

  void _startBreathing() {
    if (!_isBreathing) return;
    Future.delayed(const Duration(seconds: 4), () {
      if (_isBreathing && mounted) {
        setState(() => _breathCount++);
        _startBreathing();
      }
    });
  }

  Widget _buildTip(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// SETTINGS SCREEN
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _fluidSpeed = 0.5;
  double _touchSensitivity = 1.0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const Text(
            'Appearance',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Simulation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fluid Speed: ${_fluidSpeed.toStringAsFixed(1)}x',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Slider(
                    value: _fluidSpeed,
                    min: 0.1,
                    max: 2.0,
                    divisions: 19,
                    onChanged: (value) => setState(() => _fluidSpeed = value),
                  ),
                  const Text(
                    'Controls animation speed',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Touch Sensitivity: ${_touchSensitivity.toStringAsFixed(1)}x',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Slider(
                    value: _touchSensitivity,
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    onChanged: (value) =>
                        setState(() => _touchSensitivity = value),
                  ),
                  const Text(
                    'Adjust touch response strength',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'About',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kawaii Fluid: ASMR Therapy',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Version 2.0.0'),
                  SizedBox(height: 8),
                  Text(
                    'Advanced fluid simulation app using real-time shaders for anxiety relief and relaxation. Touch the screen to create mesmerizing waves and patterns.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// FLUID SIMULATION SCREEN avec Shaders
class FluidSimulationScreen extends StatefulWidget {
  final FluidTheme theme;

  const FluidSimulationScreen({super.key, required this.theme});

  @override
  State<FluidSimulationScreen> createState() => _FluidSimulationScreenState();
}

class _FluidSimulationScreenState extends State<FluidSimulationScreen>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _time = 0;
  Offset _touchPosition = const Offset(0.5, 0.5);
  double _touchStrength = 0.0;
  ui.FragmentShader? _shader;

  @override
  void initState() {
    super.initState();
    _loadShader();
    _ticker = createTicker((elapsed) {
      setState(() {
        _time = elapsed.inMilliseconds / 1000.0;
        _touchStrength *= 0.95; // Fade out touch effect
      });
    });
    _ticker.start();
  }

  Future<void> _loadShader() async {
    final program =
        await ui.FragmentProgram.fromAsset('assets/shaders/fluid.frag');
    setState(() {
      _shader = program.fragmentShader();
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _shader?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onPanDown: (details) => _updateTouch(details.localPosition),
            onPanUpdate: (details) => _updateTouch(details.localPosition),
            child: CustomPaint(
              painter: _shader != null
                  ? FluidPainter(
                      shader: _shader!,
                      time: _time,
                      touch: _touchPosition,
                      touchStrength: _touchStrength,
                      theme: widget.theme,
                    )
                  : null,
              child: Container(
                color: widget.theme.backgroundColor,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style:
                        IconButton.styleFrom(backgroundColor: Colors.black26),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.theme.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateTouch(Offset position) {
    final size = MediaQuery.of(context).size;
    setState(() {
      _touchPosition = Offset(
        position.dx / size.width,
        position.dy / size.height,
      );
      _touchStrength = 1.0;
    });
  }
}

class FluidPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final double time;
  final Offset touch;
  final double touchStrength;
  final FluidTheme theme;

  FluidPainter({
    required this.shader,
    required this.time,
    required this.touch,
    required this.touchStrength,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);
    shader.setFloat(3, touch.dx);
    shader.setFloat(4, touch.dy);
    shader.setFloat(5, touchStrength);

    // Couleurs du thème
    final colors = theme.colors;
    shader.setFloat(6, ((colors[0].toARGB32() >> 16) & 0xFF) / 255.0);
    shader.setFloat(7, ((colors[0].toARGB32() >> 8) & 0xFF) / 255.0);
    shader.setFloat(8, (colors[0].toARGB32() & 0xFF) / 255.0);
    shader.setFloat(9, ((colors[1].toARGB32() >> 16) & 0xFF) / 255.0);
    shader.setFloat(10, ((colors[1].toARGB32() >> 8) & 0xFF) / 255.0);
    shader.setFloat(11, (colors[1].toARGB32() & 0xFF) / 255.0);
    shader.setFloat(12, ((colors[2].toARGB32() >> 16) & 0xFF) / 255.0);
    shader.setFloat(13, ((colors[2].toARGB32() >> 8) & 0xFF) / 255.0);
    shader.setFloat(14, (colors[2].toARGB32() & 0xFF) / 255.0);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(FluidPainter oldDelegate) => true;
}

// FLUID THEMES
enum FluidTheme {
  kawaii,
  ocean,
  fire,
  galaxy,
  candy,
  sunset;

  String get displayName {
    switch (this) {
      case FluidTheme.kawaii:
        return '🌸 Kawaii';
      case FluidTheme.ocean:
        return '🌊 Ocean';
      case FluidTheme.fire:
        return '🔥 Fire';
      case FluidTheme.galaxy:
        return '🌌 Galaxy';
      case FluidTheme.candy:
        return '🍬 Candy';
      case FluidTheme.sunset:
        return '🌅 Sunset';
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
      case FluidTheme.sunset:
        return const Color(0xFF2a1810);
    }
  }

  List<Color> get colors {
    switch (this) {
      case FluidTheme.kawaii:
        return [
          const Color(0xFFf7a8b8),
          const Color(0xFFa7d7c5),
          const Color(0xFFc9b7db),
        ];
      case FluidTheme.ocean:
        return [
          const Color(0xFF0099CC),
          const Color(0xFF66CCCC),
          const Color(0xFF0066AA),
        ];
      case FluidTheme.fire:
        return [
          const Color(0xFFFF6600),
          const Color(0xFFFF0000),
          const Color(0xFFFFCC00),
        ];
      case FluidTheme.galaxy:
        return [
          const Color(0xFF660099),
          const Color(0xFF9933CC),
          const Color(0xFF330066),
        ];
      case FluidTheme.candy:
        return [
          const Color(0xFFFF69B4),
          const Color(0xFFFFB6C1),
          const Color(0xFFFF1493),
        ];
      case FluidTheme.sunset:
        return [
          const Color(0xFFFF8C00),
          const Color(0xFFFF6347),
          const Color(0xFFFFD700),
        ];
    }
  }
}
