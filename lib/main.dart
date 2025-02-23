import 'package:esprit/auth/Splash_Screen.dart';
import 'package:esprit/auth/login_screen.dart';
import 'package:esprit/views/add_mods_screen.dart';
import 'package:esprit/views/community_screen.dart';
import 'package:esprit/views/edit_community_screen.dart';
import 'package:esprit/views/feed_screen.dart';
import 'package:esprit/views/mod_tools_screen.dart';
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
        primarySwatch: Colors.red,
      ),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          return RouteMap(
            routes: {
              '/': (route) => const MaterialPage(child: SplashScreen()),
              '/login': (route) => const MaterialPage(child: LoginScreen()),
              '/home': (route) => const MaterialPage(child: HomeScreen()),
              '/add-post': (route) =>
                  const MaterialPage(child: AddPostScreen()),
              '/discuter': (route) =>
                  const MaterialPage(child: DiscussionsScreen()),
            },
          );
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
