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
  bool isLoading = false;
  String searchQuery = '';

  // Mock list of members with avatars
  final List<Map<String, String>> mockMembers = [
    {
      'uid': 'user1',
      'name': 'Alice',
      'avatar': 'https://via.placeholder.com/50?text=Alice'
    },
    {
      'uid': 'user2',
      'name': 'Bob',
      'avatar': 'https://via.placeholder.com/50?text=Bob'
    },
    {
      'uid': 'user3',
      'name': 'Charlie',
      'avatar': 'https://via.placeholder.com/50?text=Charlie'
    },
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

  // Filter members based on search query
  List<Map<String, String>> get filteredMembers {
    if (searchQuery.isEmpty) return mockMembers;
    return mockMembers
        .where((member) =>
            member['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> saveMods() async {
    if (uids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one moderator.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate an async save operation (e.g., API call)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Moderators'),
        content: Text('Add ${uids.length} moderator(s) to ${widget.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Added ${uids.length} moderators to ${widget.name}'),
                  backgroundColor: Colors.green,
                ),
              );
              print('Selected moderators: $uids');
              // Optionally navigate back
              // Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Moderators to ${widget.name}'),
        actions: [
          IconButton(
            onPressed: isLoading ? null : saveMods,
            icon: const Icon(Icons.done),
            tooltip: 'Save',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search members...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                // Member List
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredMembers.length,
                    itemBuilder: (BuildContext context, int index) {
                      final member = filteredMembers[index];
                      final uid = member['uid']!;
                      final name = member['name']!;
                      final avatar = member['avatar']!;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CheckboxListTile(
                            value: uids.contains(uid),
                            onChanged: (val) {
                              if (val!) {
                                addUid(uid);
                              } else {
                                removeUid(uid);
                              }
                            },
                            title: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(avatar),
                                  radius: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            activeColor: Colors.blue,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Selected Count
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Selected: ${uids.length} moderator(s)',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
    );
  }
}
