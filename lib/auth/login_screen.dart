import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/esprit.png',
              height: 200,
              width: 250,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    // Simulate an asynchronous task (e.g., login API call)
    Future.delayed(const Duration(seconds: 1), () {
      try {
        print("Login button pressed");
        Routemaster.of(context).push('/home');
      } catch (e, stackTrace) {
        print("Erreur lors de la navigation vers /home: $e");
        print(stackTrace);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    });
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  child: const Text('Se connecter'),
),
          ],
        ),
      ),
    );
  }
}