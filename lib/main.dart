import 'package:esprit/auth/Splash_Screen';
import 'package:esprit/auth/login_screen';
import 'package:esprit/views/Settings_screen';
import 'package:esprit/views/add_mods_screen.dart';
import 'package:esprit/views/community_screen.dart';
import 'package:esprit/views/edit_community_screen.dart';
import 'package:esprit/views/feed_screen.dart';
import 'package:esprit/views/mod_tools_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SettingsScreen() ,
    );
  }
}
