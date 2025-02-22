import 'package:flutter/material.dart';
import 'privacy_policy_screen.dart'; // Ajoutez cet import pour PrivacyPolicyScreen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true; // Valeur par défaut pour Push notifications (rouge)
  bool _darkMode = false; // Valeur par défaut pour Dark mode (blanc)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/esprit.png', // Ajoutez le chemin de votre logo Esprit dans assets
            height: 40, // Ajustez la taille selon vos besoins
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.grey),
            title: const Text('Account Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Ajoutez ici la navigation vers l'écran "Account Settings"
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.grey),
            title: const Text('Edit profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.grey),
            title: const Text('Change password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Ajoutez ici la navigation vers l'écran "Change password"
            },
          ),
          SwitchListTile(
            title: const Text('Push notifications'),
            value: _pushNotifications,
            onChanged: (value) {
              setState(() {
                _pushNotifications = value;
              });
            },
            secondary: const Icon(Icons.notifications, color: Colors.grey),
            activeColor: Colors.red, // Interrupteur rouge comme dans l’image
            inactiveThumbColor: Colors.grey[400], // Pouce gris quand désactivé
            inactiveTrackColor: Colors.grey[300], // Piste grise quand désactivé
          ),
          SwitchListTile(
            title: const Text('Dark mode'),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
            secondary: const Icon(Icons.brightness_6, color: Colors.grey),
            activeColor: Colors.white, // Interrupteur blanc comme dans l’image
            inactiveThumbColor: Colors.grey[400], // Pouce gris quand désactivé
            inactiveTrackColor: Colors.grey[300], // Piste grise quand désactivé
            activeTrackColor: Colors.grey[600], // Piste grise foncée quand activé
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.grey),
            title: const Text('About us'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Ajoutez ici la navigation vers l'écran "About us"
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.grey),
            title: const Text('Privacy policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.grey),
            title: const Text('Terms and conditions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Ajoutez ici la navigation vers l'écran "Terms and conditions"
            },
          ),
          ListTile(
            leading: const Icon(Icons.switch_account, color: Colors.grey),
            title: const Text('Change account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Ajoutez ici la navigation vers l'écran "Change account"
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.grey),
            title: const Text('Delete Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Ajoutez ici la navigation vers l'écran "Delete Account"
            },
          ),
        ],
      ),
    );
  }
}