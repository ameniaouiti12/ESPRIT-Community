import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:routemaster/routemaster.dart';

import 'NavBar.dart'; // Pour la navigation, si nécessaire
import 'ProfileDrawer.dart'; // Importer le widget ProfileDrawer
import 'CommunityListDrawer.dart'; // Importer le widget CommunityListDrawer

class DiscussionsScreen extends StatefulWidget {
  const DiscussionsScreen({super.key});

  @override
  State<DiscussionsScreen> createState() => _DiscussionsScreenState();
}

class _DiscussionsScreenState extends State<DiscussionsScreen> {
  bool _chatChannels = true;
  bool _groupDiscussions = true;
  bool _instantDiscussions = true;

  void _applyFilter() {
    setState(() {});
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[700], size: 24),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Text(
                    'Filtrer les discussions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: const Text('Canaux de discussion', style: TextStyle(fontSize: 16)),
                    value: _chatChannels,
                    onChanged: (value) => setState(() => _chatChannels = value ?? false),
                    activeColor: Colors.red[800],
                    checkColor: Colors.white,
                    tileColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  CheckboxListTile(
                    title: const Text('Discussions de groupe', style: TextStyle(fontSize: 16)),
                    value: _groupDiscussions,
                    onChanged: (value) => setState(() => _groupDiscussions = value ?? false),
                    activeColor: Colors.red[800],
                    checkColor: Colors.white,
                    tileColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  CheckboxListTile(
                    title: const Text('Discussions instantanées', style: TextStyle(fontSize: 16)),
                    value: _instantDiscussions,
                    onChanged: (value) => setState(() => _instantDiscussions = value ?? false),
                    activeColor: Colors.red[800],
                    checkColor: Colors.white,
                    tileColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _applyFilter();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                    ),
                    child: const Text('Appliquer les filtres', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToNewDiscussionRoom(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewDiscussionRoomScreen()),
    );
  }

  void _navigateToGroupDiscussion(BuildContext context, String channelTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDiscussionScreen(channelTitle: channelTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: const Text(
          'Discussions',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black87),
            onPressed: () => _showFilterBottomSheet(context),
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: const CircleAvatar(backgroundColor: Colors.grey),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              );
            },
          ),
        ],
      ),
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explorer les canaux',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Voir tout',
                    style: TextStyle(color: Colors.red[800], fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                SizedBox(
                  height: 130,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildChannelTile(
                          title: 'ESPRIT Ingénieur',
                          subtitle: '150 messages récents',
                          icon: Icons.engineering,
                          onTap: () => _navigateToGroupDiscussion(context, 'ESPRIT Ingénieur'),
                        ),
                        const SizedBox(width: 12),
                        _buildChannelTile(
                          title: 'ESPRIT Business School',
                          subtitle: 'Récemment visité',
                          icon: Icons.business,
                          onTap: () => _navigateToGroupDiscussion(context, 'ESPRIT Business School'),
                          timestamp: '18:13',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Discutez de vos sujets préférés avec d\'autres utilisateurs.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[800],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Explorer les canaux', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 3,
        onTap: (index) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNewDiscussionRoom(context),
        backgroundColor: Colors.red[800],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 30),
        shape: const CircleBorder(),
        elevation: 6,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildChannelTile({
    required String title,
    required String subtitle,
    IconData? icon,
    String? timestamp,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(icon, size: 36, color: Colors.red[800]),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (timestamp != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  timestamp,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NewDiscussionRoomScreen extends StatefulWidget {
  const NewDiscussionRoomScreen({super.key});

  @override
  State<NewDiscussionRoomScreen> createState() => _NewDiscussionRoomScreenState();
}

class _NewDiscussionRoomScreenState extends State<NewDiscussionRoomScreen> {
  final TextEditingController _pseudoController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _pseudoController.dispose();
    super.dispose();
  }

  void _searchPseudos(String query) {
    if (query.length < 3) {
      setState(() {
        _errorMessage = 'Entrez au moins trois caractères pour rechercher.';
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
    }
  }

  void _createDiscussionRoom() {
    if (_pseudoController.text.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Salon de discussion créé avec succès')),
      );
      Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = 'Entrez au moins trois caractères pour créer un salon.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Nouveau salon de discussion',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _createDiscussionRoom,
            child: Text(
              'Créer',
              style: TextStyle(
                color: Colors.red[800],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recherchez des personnes par pseudo pour commencer une discussion.',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _pseudoController,
              decoration: InputDecoration(
                hintText: 'Rechercher des pseudos',
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                errorText: _errorMessage,
                errorStyle: TextStyle(color: Colors.red[800]),
              ),
              onChanged: _searchPseudos,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }
}

class GroupDiscussionScreen extends StatefulWidget {
  final String channelTitle;

  const GroupDiscussionScreen({super.key, required this.channelTitle});

  @override
  State<GroupDiscussionScreen> createState() => _GroupDiscussionScreenState();
}

class _GroupDiscussionScreenState extends State<GroupDiscussionScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ImagePicker _picker = ImagePicker();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'type': 'text',
          'content': _messageController.text,
          'time': TimeOfDay.now().format(context),
        });
        _messageController.clear();
      });
    }
  }

  void _sendImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _messages.add({
          'type': 'image',
          'content': image.path,
          'time': TimeOfDay.now().format(context),
        });
      });
    }
  }

  void _sendEmoji(String emoji) {
    setState(() {
      _messages.add({
        'type': 'emoji',
        'content': emoji,
        'time': TimeOfDay.now().format(context),
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          children: [
            for (var emoji in ['😊', '😂', '😢', '👍', '👎', '❤️', '😎', '🤔', '😍', '😱'])
              GestureDetector(
                onTap: () {
                  _sendEmoji(emoji);
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 30)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.channelTitle,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message['type'] == 'text')
                        Text(
                          message['content'],
                          style: const TextStyle(color: Colors.black87, fontSize: 16),
                        )
                      else if (message['type'] == 'image')
                        Image.file(
                          File(message['content']),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      else if (message['type'] == 'emoji')
                          Text(
                            message['content'],
                            style: const TextStyle(fontSize: 24),
                          ),
                      const SizedBox(height: 4),
                      Text(
                        message['time'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Tapez un message...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.sentiment_satisfied, color: Colors.grey[600]),
                        onPressed: () => _showEmojiPicker(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.image, color: Colors.grey[600]),
                  onPressed: _sendImage,
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.red[800]),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }
}