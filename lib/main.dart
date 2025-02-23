import 'package:esprit/auth/Splash_Screen.dart';
import 'package:esprit/auth/login_screen.dart';
import 'package:esprit/views/Edit_Profile_Screen.dart';
import 'package:esprit/views/PodcastScreen.dart';
import 'package:esprit/views/Profile_Screen.dart';
import 'package:esprit/views/add_mods_screen.dart';
import 'package:esprit/views/community_screen.dart';
import 'package:esprit/views/create_community_screen.dart';
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
              '/communities': (route) => const MaterialPage(
                    child: CommunityScreen(
                        name: 'flutter'), // Default community name
                  ),
              '/create-community': (route) => const MaterialPage(
                    child: CreateCommunityScreen(),
                  ),
              '/Profil': (route) => const MaterialPage(
                    child: ProfileScreen(),
                  ),
              '/podcast': (_) =>
                  MaterialPage(child: PodcastScreen()), // Add Podcast route
              '/edit-community': (route) => MaterialPage(
                    child: EditCommunityScreen(
                      name: route.queryParameters['name'] ?? 'flutter',
                    ),
                  ),
              '/edit-profile': (_) =>
                  const MaterialPage(child: EditProfileScreen()), // Added route
            },
          );
        },
      ),
      debugShowCheckedModeBanner:
          false, // Ajout de cette ligne pour supprimer la bannière de debug
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
