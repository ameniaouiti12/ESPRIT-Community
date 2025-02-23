import 'package:esprit/views/CommunityListDrawer.dart';
import 'package:esprit/views/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For system UI customization
import 'mod_tools_screen.dart'; // Assuming this file exists
import 'package:routemaster/routemaster.dart'; // For ProfileDrawer navigation

class CommunityScreen extends StatefulWidget {
  final String name;
  const CommunityScreen({super.key, required this.name});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  // Mock community data (for the current community)
  final Map<String, dynamic> mockCommunity = {
    'name': 'flutter',
    'banner': 'https://via.placeholder.com/400x150',
    'avatar': 'https://via.placeholder.com/100',
    'members': ['user1', 'user2', 'user3'],
    'mods': ['user1'],
  };

  // Mock user data
  final Map<String, dynamic> mockUser = {
    'uid': 'user2',
    'isAuthenticated': true,
  };

  // Mock community data for recommendations
  final List<Map<String, dynamic>> mockCommunities = [
    {
      'name': 'wholesomememes',
      'avatar': 'https://via.placeholder.com/50?text=WM',
      'members': '18.3m',
      'description':
          'Bienvenue sur le côté positif d’internet ! Des mèmes qui font sourire.',
      'isJoined': false,
    },
    {
      'name': 'buccaneers',
      'avatar': 'https://via.placeholder.com/50?text=BUC',
      'members': '197k',
      'description':
          'Fête les Buccaneers de Tampa Bay, champions du Super Bowl à deux reprises.',
      'isJoined': false,
    },
    {
      'name': 'AnimalsBeingBros',
      'avatar': 'https://via.placeholder.com/50?text=AB',
      'members': '6.9m',
      'description':
          'Célèbre les façons adorables et touchantes dont les animaux s’entraident.',
      'isJoined': false,
    },
    {
      'name': 'Awww',
      'avatar': 'https://via.placeholder.com/50?text=AW',
      'members': '999k',
      'description':
          'Partage ton amour pour tout ce qui est mignon et attendrissant sur Reddit.',
      'isJoined': false,
    },
  ];

  // Mock thematic categories
  final List<String> mockCategories = [
    'Culture Internet',
    'Jeux',
    'Actualités et politique',
    'Questions-réponses',
    'Technologie',
    'Films et séries',
    'Lieux et voyages',
    'Pop culture',
  ];

  String? selectedCategory;
  bool isLoading = false;
  bool hasError = false;
  late AnimationController _animationController;
  int _currentIndex = 1; // Default to "Communautés" (index 1)

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void navigateToModTools(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModToolsScreen(name: widget.name),
      ),
    );
  }

  void toggleJoinCommunity(String communityName) {
    setState(() {
      final community =
          mockCommunities.firstWhere((c) => c['name'] == communityName);
      community['isJoined'] = !community['isJoined'];
      if (community['isJoined']) {
        print('Joined $communityName');
      } else {
        print('Left $communityName');
      }
    });
  }

  Future<void> refreshCommunities() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
      if (DateTime.now().second % 5 == 0) {
        hasError = true;
      } else {
        mockCommunities.shuffle();
      }
    });
  }

  List<Map<String, dynamic>> getFilteredCommunities() {
    if (selectedCategory == null) return mockCommunities;
    return mockCommunities.where((community) {
      final categoryMap = {
        'Culture Internet': ['wholesomememes'],
        'Jeux': [],
        'Actualités et politique': [],
        'Questions-réponses': [],
        'Technologie': ['flutter'],
        'Films et séries': [],
        'Lieux et voyages': [],
        'Pop culture': ['buccaneers', 'Awww'],
      };
      return categoryMap[selectedCategory]!.contains(community['name']);
    }).toList();
  }

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    final user = mockUser;
    final isGuest = !user['isAuthenticated'];
    final communities = getFilteredCommunities();

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          'Communautés',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CommunitySearchDelegate(mockCommunities),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer(); // Open ProfileDrawer
              },
              child: Image.asset(
                'assets/avatar.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.red[900],
        elevation: 0,
      ),
      drawer: const CommunityListDrawer(), // Left-side drawer
      endDrawer: const ProfileDrawer(), // Right-side drawer for profile
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: refreshCommunities,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : hasError
                ? Center(
                    child: ErrorWidget(
                      'Une erreur est survenue. Veuillez réessayer.',
                      onRetry: refreshCommunities,
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mockCategories.length,
                            itemBuilder: (context, index) {
                              final isSelected =
                                  selectedCategory == mockCategories[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedCategory = isSelected
                                            ? null
                                            : mockCategories[index];
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSelected
                                          ? Colors.red
                                          : Colors.grey[200],
                                      foregroundColor: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(mockCategories[index]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Recommandées pour toi',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            itemCount: communities.length,
                            itemBuilder: (BuildContext context, int index) {
                              final community = communities[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: AnimatedScale(
                                  scale: 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                community['avatar']),
                                            radius: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  community['name'],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '${community['members']} membres',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  community['description'],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          OutlinedButton(
                                            onPressed: () =>
                                                toggleJoinCommunity(
                                                    community['name']),
                                            style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              foregroundColor: Colors.black,
                                              side:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            child: Text(community['isJoined']
                                                ? 'Rejoint'
                                                : 'Rejoindre'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}

// Custom Error Widget
class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorWidget(this.message, {required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Réessayer'),
        ),
      ],
    );
  }
}

// Search Delegate for Communities
class CommunitySearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> communities;

  CommunitySearchDelegate(this.communities);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredCommunities = communities
        .where((community) =>
            community['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredCommunities.length,
      itemBuilder: (context, index) {
        final community = filteredCommunities[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(community['avatar']),
            radius: 20,
          ),
          title: Text(community['name']),
          subtitle: Text('${community['members']} membres'),
          onTap: () {
            close(context, community['name']);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}

// Profile Drawer Widget (kept as provided)
class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  void navigateToUserProfile(BuildContext context) {
    Routemaster.of(context).push('/Profil');
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
