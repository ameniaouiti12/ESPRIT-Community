import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart'; // Add Routemaster import

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the animation after a short delay
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Navigate to LoginScreen after 5 seconds using Routemaster
    Future.delayed(const Duration(seconds: 5), () {
      Routemaster.of(context).replace('/login'); // Use replace to clear the SplashScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: Image.asset(
            'assets/esprit.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}