import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_base/presentation/routes/route_name.dart';
import 'package:flutter_base/presentation/screen/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _backgroundController;
  late AnimationController _textController;
  late AnimationController _particlesController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _textOpacityAnimation;

  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 50; i++) {
      _particles.add(
        Particle(
          position: Offset(
            math.Random().nextDouble() * 400 - 200,
            math.Random().nextDouble() * 400 - 200,
          ),
          size: math.Random().nextDouble() * 10 + 5,
          speed: math.Random().nextDouble() * 2 + 1,
          color: Color.fromRGBO(
            math.Random().nextInt(255),
            math.Random().nextInt(255),
            255,
            math.Random().nextDouble() * 0.6 + 0.2,
          ),
        ),
      );
    }

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _particlesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward();

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticInOut),
    );

    _logoRotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInCubic),
    );

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _backgroundController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _logoController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      _textController.forward();
    });
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _backgroundController.dispose();
    _textController.dispose();
    _particlesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(Colors.black, Color(0xFF1A2980), _backgroundAnimation.value)!,
                      Color.lerp(Colors.black, Color(0xFF26D0CE), _backgroundAnimation.value)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          // AnimatedBuilder(
          //     animation: _particlesController,
          //     builder: (context, child) {
          //       return CustomPaint(
          //         painter: ParticlePainter(_particles, _particlesController.value),
          //         size: Size.infinite,
          //       );
          //     }),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Transform.rotate(
                          angle: _logoRotationAnimation.value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.flutter_dash,
                                size: 80,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 40,
                ),
                SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _textOpacityAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Welcome to Flutter',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Your journey begins here',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Particle {
  Offset position;
  double size;
  Color color;
  double speed;

  Particle({
    required this.position,
    required this.size,
    required this.color,
    required this.speed,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;

  ParticlePainter(this.particles, this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;

      final centerX = size.width / 2;
      final centerY = size.height / 2;
      final angle = math.atan2(particle.position.dy, particle.position.dx);
      final currentDistance = math.sqrt(math.pow(particle.position.dx, 2) + math.pow(particle.position.dy, 2));
      final x = centerX + math.cos(angle + animation + particle.speed) * currentDistance;
      final y = centerY + math.sin(angle + animation + particle.speed) * currentDistance;
      final pulsateSize = particle.size * (0.8 + 0.4 * math.sin(animation * 5));
      canvas.drawCircle(Offset(x, y), pulsateSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
