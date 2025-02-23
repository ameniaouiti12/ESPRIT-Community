import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends StatefulWidget {
  const CommunityListDrawer({super.key});

  @override
  State<CommunityListDrawer> createState() => _CommunityListDrawerState();
}

class _CommunityListDrawerState extends State<CommunityListDrawer> {
  bool _isYourCommunityListExpanded = true; // Your communities open by default
  // Map to track favorite status of each community
  final Map<String, bool> _favoriteCommunities = {
    'ESPRIT Ingénieur': false,
    'ESPRIT Business School': false,
    'Centre de Carrière Esprit': false,
  };

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, String communityName) {
    Routemaster.of(context).push('/$communityName');
  }

  void navigateToAllCommunities(BuildContext context) {
    Routemaster.of(context).push('/all-communities');
  }

  void toggleFavorite(String community) {
    setState(() {
      _favoriteCommunities[community] = !_favoriteCommunities[community]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> yourCommunities = [
      'ESPRIT Ingénieur',
      'ESPRIT Business School',
      'Centre de Carrière Esprit',
    ];

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Your Communities Section (Expandable)
            ExpansionTile(
              title: const Text('Vos communautés'),
              leading: Icon(Icons.group, color: Colors.red[900]),
              initiallyExpanded: _isYourCommunityListExpanded,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isYourCommunityListExpanded = expanded;
                });
              },
              children: [
                ListTile(
                  title: const Text('Créer une communauté'),
                  leading: Icon(Icons.add, color: Colors.red[900]),
                  onTap: () => navigateToCreateCommunity(context),
                ),
                ...yourCommunities.map((community) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(_getImageForCommunity(community)),
                        radius: 16,
                      ),
                      title: Text(community),
                      trailing: IconButton(
                        icon: Icon(
                          _favoriteCommunities[community]!
                              ? Icons.star
                              : Icons.star_border,
                          color: _favoriteCommunities[community]!
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                        onPressed: () => toggleFavorite(community),
                      ),
                      onTap: () => navigateToCommunity(context, community),
                    )),
              ],
            ),
            // All Communities Section (Single Link)
            ListTile(
              title: const Text('Toutes'),
              leading: Icon(Icons.public, color: Colors.red[900]),
              onTap: () => navigateToAllCommunities(context),
            ),
            const Expanded(child: SizedBox()), // Keeps layout consistent
          ],
        ),
      ),
    );
  }

  String _getImageForCommunity(String community) {
    switch (community) {
      case 'ESPRIT Ingénieur':
        return 'Esprit.jpeg';
      case 'ESPRIT Business School':
        return 'espritC-C.jpeg';
      case 'Centre de Carrière Esprit':
        return 'esb.jpeg';
      default:
        return 'Esprit.jpeg'; // Fallback image
    }
  }
}
