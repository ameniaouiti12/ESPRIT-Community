import 'package:esprit/auth/Splash_Screen';
import 'package:esprit/auth/login_screen';
import 'package:esprit/views/Settings_screen';
import 'package:esprit/views/add_mods_screen.dart';
import 'package:esprit/views/community_screen.dart';
import 'package:esprit/views/edit_community_screen.dart';
import 'package:esprit/views/feed_screen.dart';
import 'package:esprit/views/mod_tools_screen.dart';
import 'package:flutter/material.dart';

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
