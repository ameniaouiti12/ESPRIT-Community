import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  void navigateToUserProfile(BuildContext context) {
    Routemaster.of(context).push('/u/example'); // Using static example UID
  }

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToHistory(BuildContext context) {
    Routemaster.of(context).push('/history');
  }

  void navigateToSettings(BuildContext context) {
    Routemaster.of(context).push('/settings');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey, // Placeholder avatar
              radius: 70,
            ),
            const SizedBox(height: 10),
            const Text(
              'Ameni', // Static username
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              title: const Text('Profil'),
              leading: Icon(
                Icons.person,
                color: Colors.red[900],
              ),
              onTap: () => navigateToUserProfile(context),
            ),
            ListTile(
              title: const Text('Créer une communauté'),
              leading: Icon(
                Icons.add_circle,
                color: Colors.red[900],
              ),
              onTap: () => navigateToCreateCommunity(context),
            ),
            ListTile(
              title: const Text('Historique'),
              leading: Icon(
                Icons.history,
                color: Colors.red[900],
              ),
              onTap: () => navigateToHistory(context),
            ),
            ListTile(
              title: const Text('Paramètres'),
              leading: Icon(
                Icons.settings,
                color: Colors.red[900],
              ),
              onTap: () => navigateToSettings(context),
            ),
          ],
        ),
      ),
    );
  }
}
