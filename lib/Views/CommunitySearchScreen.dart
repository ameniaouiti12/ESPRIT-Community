import 'package:flutter/material.dart';

class CommunitySearchScreen extends StatefulWidget {
  const CommunitySearchScreen({super.key});

  @override
  State<CommunitySearchScreen> createState() => _CommunitySearchScreenState();
}

class _CommunitySearchScreenState extends State<CommunitySearchScreen> {
  final _searchController = TextEditingController();
  List<String> communities = [
    'ESPRIT Ingénieur',
    'Tech Community',
    'Flutter Devs',
    'AI Enthusiasts',
    'Design Hub',
  ];
  List<String> filteredCommunities = [];

  @override
  void initState() {
    super.initState();
    filteredCommunities = communities;
    _searchController.addListener(_filterCommunities);
  }

  void _filterCommunities() {
    setState(() {
      filteredCommunities = communities
          .where((community) => community
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select a Community',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search communities...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
            const SizedBox(height: 16),
            // Community List
            Expanded(
              child: ListView.builder(
                itemCount: filteredCommunities.length,
                itemBuilder: (context, index) {
                  final community = filteredCommunities[index];
                  return ListTile(
                    title: Text(
                      community,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, community); // Return selected community
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}