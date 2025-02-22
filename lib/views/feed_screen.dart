import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // Mock user data
  final Map<String, dynamic> mockUser = {
    'uid': 'user1',
    'isAuthenticated': true, // Toggle this to simulate guest/authenticated user
  };

  // Mock post data
  final List<Map<String, String>> mockPosts = [
    {'title': 'Post 1', 'content': 'This is the first post'},
    {'title': 'Post 2', 'content': 'This is the second post'},
    {'title': 'Post 3', 'content': 'This is the third post'},
  ];

  @override
  Widget build(BuildContext context) {
    final user = mockUser;
    final isGuest = !user['isAuthenticated'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
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
    );
  }
}