import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/seguridad/screens/inicio/screens/inicio_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/screens/login_screen.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  static String route = 'splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<Offset> _logoSlideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _logoScaleAnimation = Tween<double>(begin: 2.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.15, 0))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _logoSlideAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(-0.4, 0))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
    animationCompletedNavigateToRoute(InicioScreen.route);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animationCompletedNavigateToRoute(String route) {
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                SlideTransition(
                  position: _textSlideAnimation,
                  child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _textOpacityAnimation.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Image.asset(
                              AppImages.splashText,
                              height: 50.0,
                            ),
                          ),
                        );
                      }),
                ),
                SlideTransition(
                  position: _logoSlideAnimation,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: child,
                      );
                    },
                    child: Image.asset(
                      AppImages.splashIcon,
                      height: 100.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
