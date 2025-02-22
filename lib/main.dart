import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'Views/AddPostScreen.dart';
import 'Views/DiscussionsScreen.dart';
import 'Views/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.red, // Match your app's theme
      ),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          return RouteMap(
            routes: {
              '/': (route) => const MaterialPage(child: HomeScreen()), // Default route (home)
              '/home': (route) => const MaterialPage(child: HomeScreen()), // Home route
              '/add-post': (route) => const MaterialPage(child: AddPostScreen()), // Add post route
              '/discuter': (route) => const MaterialPage(child: DiscussionsScreen()),// Add other routes as needed

            },
          );
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
