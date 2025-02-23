import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  void navigateToUserProfile(BuildContext context) {
    Routemaster.of(context).push('/Profil'); // Navigue vers la route /Profil
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

  void navigateToClassement(BuildContext context) {
    Routemaster.of(context).push('/classement');
  }

  @override
  Widget build(BuildContext context) {
    // Static ranking data
    final List<Map<String, dynamic>> rankings = [
      {"color": Colors.red[900], "label": "1st"},
      {"color": Colors.black, "label": "2nd"},
      {"color": Colors.white, "label": "3rd"},
    ];

    return Drawer(
      child: Container(
        color: Colors.white, // Arrière-plan blanc pour le drawer
        child: SafeArea(
          child: Column(
            children: [
              // User Avatar and Name
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 70,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green, // Indicateur de statut en ligne
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ameni',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              const Divider(),

              // Enhanced Ranking Section
              GestureDetector(
                onTap: () => navigateToClassement(
                    context), // Navigation vers le classement
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Classement',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.red[900],
                              letterSpacing: 0.5,
                            ),
                          ),
                          // Flèche pour indiquer la navigation
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.red[900],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height:
                            100, // Hauteur ajustée pour les cercles superposés
                        child: Stack(
                          alignment: Alignment.center,
                          children: rankings.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> ranking = entry.value;
                            return Positioned(
                              left: index == 0
                                  ? 0
                                  : index == 2
                                      ? 60.0
                                      : 30.0, // Ajustement pour le chevauchement
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ranking["color"] as Color,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    ranking["label"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          offset: Offset(1, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),

              // Navigation Options
              ListTile(
                title: const Text('Profil'),
                leading: Icon(Icons.person, color: Colors.red[900]),
                onTap: () => navigateToUserProfile(context),
              ),
              ListTile(
                title: const Text('Créer une communauté'),
                leading: Icon(Icons.add_circle, color: Colors.red[900]),
                onTap: () => navigateToCreateCommunity(context),
              ),
              ListTile(
                title: const Text('Historique'),
                leading: Icon(Icons.history, color: Colors.red[900]),
                onTap: () => navigateToHistory(context),
              ),
              ListTile(
                title: const Text('Paramètres'),
                leading: Icon(Icons.settings, color: Colors.red[900]),
                onTap: () => navigateToSettings(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
