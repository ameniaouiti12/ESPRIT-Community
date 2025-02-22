import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class SearchCommunityDelegate extends SearchDelegate {
  SearchCommunityDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Static example data instead of provider
    final List<Map<String, String>> exampleCommunities = [
      {'name': 'example1', 'avatar': ''},
      {'name': 'example2', 'avatar': ''},
    ];

    return ListView.builder(
      itemCount: exampleCommunities.length,
      itemBuilder: (BuildContext context, int index) {
        final community = exampleCommunities[index];
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey, // Placeholder avatar
          ),
          title: Text('r/${community['name']}'),
          onTap: () => navigateToCommunity(context, community['name']!),
        );
      },
    );
  }

  void navigateToCommunity(BuildContext context, String communityName) {
    Routemaster.of(context).push('/r/$communityName');
  }
}