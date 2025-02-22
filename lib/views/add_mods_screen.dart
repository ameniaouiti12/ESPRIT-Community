import 'package:flutter/material.dart';

class AddModsScreen extends StatefulWidget {
  final String name;
  const AddModsScreen({
    super.key,
    required this.name,
  });

  @override
  State<AddModsScreen> createState() => _AddModsScreenState();
}

class _AddModsScreenState extends State<AddModsScreen> {
  Set<String> uids = {};
  // Mock list of members for demonstration (replace with your data source if needed)
  final List<Map<String, String>> mockMembers = [
    {'uid': 'user1', 'name': 'Alice'},
    {'uid': 'user2', 'name': 'Bob'},
    {'uid': 'user3', 'name': 'Charlie'},
  ];

  void addUid(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUid(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  void saveMods() {
    // For now, just print the selected UIDs (replace with your logic)
    print('Selected moderators: $uids');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Moderators to ${widget.name}'),
        actions: [
          IconButton(
            onPressed: saveMods,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: mockMembers.length,
        itemBuilder: (BuildContext context, int index) {
          final member = mockMembers[index];
          final uid = member['uid']!;
          final name = member['name']!;

          return CheckboxListTile(
            value: uids.contains(uid),
            onChanged: (val) {
              if (val!) {
                addUid(uid);
              } else {
                removeUid(uid);
              }
            },
            title: Text(name),
          );
        },
      ),
    );
  }
}
