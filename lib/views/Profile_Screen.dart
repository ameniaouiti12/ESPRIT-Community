import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:esprit/Views/NavBar.dart'; // Assuming this is the correct path

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const List<Map<String, String>> userCommunities = [
    {'name': 'flutter', 'role': 'Membre'},
    {'name': 'wholesomememes', 'role': 'Modérateur'},
    {'name': 'buccaneers', 'role': 'Membre'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => _navigateToHome(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 20),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
            onPressed: () {
              // TODO: Implement refresh functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProfileHeader(context),
          _buildTabsSection(context),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex:
            0, // Default to "Accueil" since Profile isn’t in the navbar
        onTap: (index) {}, // Required but unused; navigation handled internally
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    try {
      Routemaster.of(context).push('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de navigation: $e')),
      );
    }
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red[900]!, Colors.black],
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage:
                const AssetImage('assets/ameni.jpeg'), // Added Ameni's image
          ),
          const SizedBox(height: 8),
          _buildOutlinedButton(
            text: 'Modifier',
            onPressed: () => _navigateToEditProfile(
                context), // Navigate to EditProfileScreen
          ),
          const SizedBox(height: 8),
          const Text(
            'Ameni Aouiti', // Updated username
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Row(
            children: [
              Text(
                '5 trophées ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Icon(Icons.emoji_events, color: Colors.orange, size: 16),
              Text(
                ' >',
                style: TextStyle(color: Colors.orange, fontSize: 16),
              ),
            ],
          ),
          const Text(
            'u/Ameni-Aouiti • 1 karma • févr. 18, 2025', // Updated username in handle
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const Text(
            'Quantité d’or : 0',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          _buildOutlinedButton(
            text: 'Ajouter un réseau social',
            onPressed: () {
              // TODO: Implement social media linking
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabsSection(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Colors.red[900],
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.red[900],
                tabs: const [
                  Tab(text: 'Publications'),
                  Tab(text: 'Communauté'),
                  Tab(text: 'À propos'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPublicationsTab(),
                  _buildCommunitiesTab(context),
                  _buildAboutTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPublicationsTab() {
    return Container(
      color: Colors.grey[100],
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Nouvelles publications',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }

  Widget _buildCommunitiesTab(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: userCommunities.isEmpty
          ? Center(
              child: Text(
                'Aucune communauté trouvée',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: userCommunities.length,
              itemBuilder: (context, index) {
                final community = userCommunities[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[900],
                    radius: 16,
                    child: Text(
                      community['name']![0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    community['name']!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    community['role']!,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () =>
                        _navigateToEditCommunity(context, community['name']!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Éditer'),
                  ),
                  onTap: () =>
                      _navigateToCommunity(context, community['name']!),
                );
              },
            ),
    );
  }

  Widget _buildAboutTab() {
    return Container(
      color: Colors.grey[100],
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'À propos',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(
      {required String text, required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text),
    );
  }

  void _navigateToCommunity(BuildContext context, String communityName) {
    try {
      Routemaster.of(context).push('/$communityName');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de navigation: $e')),
      );
    }
  }

  void _navigateToEditCommunity(BuildContext context, String communityName) {
    try {
      Routemaster.of(context).push('/edit-community?name=$communityName');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de navigation: $e')),
      );
    }
  }

  void _navigateToEditProfile(BuildContext context) {
    try {
      Routemaster.of(context).push('/edit-profile');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de navigation: $e')),
      );
    }
  }
}
