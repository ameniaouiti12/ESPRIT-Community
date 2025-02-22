import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  final String name;
  const CommunityScreen({super.key, required this.name});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // Mock community data
  final Map<String, dynamic> mockCommunity = {
    'name': 'flutter',
    'banner': 'https://via.placeholder.com/400x150', // Placeholder banner image
    'avatar': 'https://via.placeholder.com/100', // Placeholder avatar image
    'members': ['user1', 'user2', 'user3'], // Mock member UIDs
    'mods': ['user1'], // Mock moderator UIDs
  };

  // Mock user data
  final Map<String, dynamic> mockUser = {
    'uid': 'user2',
    'isAuthenticated': true,
  };

  // Mock posts data
  final List<Map<String, String>> mockPosts = [
    {'title': 'Post 1', 'content': 'This is the first post'},
    {'title': 'Post 2', 'content': 'This is the second post'},
  ];

  bool isJoined = false;

  void navigateToModTools(BuildContext context) {
    // Simulate navigation (replace with your navigation logic if needed)
    print('Navigating to mod tools for ${widget.name}');
  }

  void joinCommunity(BuildContext context) {
    setState(() {
      isJoined = !isJoined;
      if (isJoined) {
        mockCommunity['members'].add(mockUser['uid']);
      } else {
        mockCommunity['members'].remove(mockUser['uid']);
      }
    });
    print(
        'User ${mockUser['uid']} ${isJoined ? 'joined' : 'left'} ${widget.name}');
  }

  @override
  Widget build(BuildContext context) {
    final user = mockUser;
    final isGuest = !user['isAuthenticated'];
    final community = mockCommunity;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 150,
              floating: true,
              snap: true,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      community['banner'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(community['avatar']),
                        radius: 35,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'r/${community['name']}',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!isGuest)
                          (community['mods'] as List).contains(user['uid'])
                              ? OutlinedButton(
                                  onPressed: () {
                                    navigateToModTools(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                  ),
                                  child: const Text('Mod Tools'),
                                )
                              : OutlinedButton(
                                  onPressed: () => joinCommunity(context),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                  ),
                                  child: Text((community['members'] as List)
                                          .contains(user['uid'])
                                      ? 'Joined'
                                      : 'Join'),
                                ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${(community['members'] as List).length} members',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: mockPosts.length,
          itemBuilder: (BuildContext context, int index) {
            final post = mockPosts[index];
            return Card(
              child: ListTile(
                title: Text(post['title']!),
                subtitle: Text(post['content']!),
              ),
            );
          },
        ),
      ),
    );
  }
}
