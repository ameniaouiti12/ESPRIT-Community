import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routemaster/routemaster.dart';
import 'package:share_plus/share_plus.dart';
import 'CommunityListDrawer.dart';
import 'NavBar.dart';
import 'ProfileDrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  String? _selectedMenu;
  bool _isLoading = true; // Indicateur de chargement initial

  final List<Map<String, dynamic>> communityPosts = [
    {
      'community': 'ESPRIT Ingénieur',
      'avatar': 'assets/Esprit.jpeg',
      'title': '🔥 La phase 2 de C-ool-algo-rythm arrive à grands pas ! 🔥',
      'content':
          '📅 26 février 2025\n⏰ 13h\n📍 Amphithéâtre Bloc G\nRejoignez-nous pour la phase 2 de C-ool-algo-rythm et plongez dans l\'innovation ! 🚀🏆\n#CooLAlgoRythm #Phase2 #Innovation #EspritTech\n@Honoris United Universities',
      'image': 'assets/event.jpg',
      'upvotes': 35,
      'downvotes': 0,
      'comments': [],
      'isUpvoted': false,
      'isDownvoted': false,
    },
    {
      'community': 'ESPRIT International',
      'avatar': 'assets/Esprit.jpeg',
      'title': 'Partenariat avec Beijing Polytechnic',
      'content':
          '𝗟𝗲 𝗴𝗿𝗼𝘂𝗽𝗲 𝗘𝘀𝗽𝗿𝗶𝘁 𝗮 𝗲𝘂 𝗹’𝗵𝗼𝗻𝗻𝗲𝘂𝗿 𝗱’𝗮𝗰𝗰𝘂𝗲𝗶𝗹𝗹𝗶𝗿 𝘂𝗻𝗲 𝗱𝗲́𝗹𝗲́𝗴𝗮𝘁𝗶𝗼𝗻 𝗱𝗲 𝗕𝗲𝗶𝗷𝗶𝗻𝗴 𝗣𝗼𝗹𝘆𝘁𝗲𝗰𝗵𝗻𝗶𝗰, une université chinoise de renom dans le cadre du renouvellement d’un partenariat stratégique entre nos deux universités.\nCe partenariat ouvre la voie à des échanges académiques, culturels et scientifiques prometteurs pour nos étudiants et enseignants.\n#PartenariatInternational #CoopérationAcadémique\nHonoris United Universities',
      'image': 'assets/taher.jpg', // Assuming the image is named taher.jpeg
      'upvotes': 42,
      'downvotes': 1,
      'comments': [],
      'isUpvoted': false,
      'isDownvoted': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _preloadAssets();
  }

  Future<void> _preloadAssets() async {
    try {
      // Précharger les images pour éviter les blocages
      await Future.wait([
        precacheImage(const AssetImage('assets/esprit.png'), context),
        for (var post in communityPosts)
          precacheImage(AssetImage(post['avatar']), context),
        for (var post in communityPosts)
          if (post['image'] != null)
            precacheImage(AssetImage(post['image']), context),
        precacheImage(const AssetImage('assets/ameni.jpeg'),
            context), // Preload Ameni's image
        precacheImage(const AssetImage('assets/taher.jpeg'),
            context), // Preload Taher's image
      ]);
      setState(() {
        _isLoading = false; // Chargement terminé
      });
    } catch (e) {
      print('Erreur lors du préchargement des assets: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void displayDrawer(BuildContext context) {
    try {
      Scaffold.of(context).openDrawer();
    } catch (e) {
      print("Erreur lors de l'ouverture du drawer: $e");
    }
  }

  void displayEndDrawer(BuildContext context) {
    try {
      Scaffold.of(context).openEndDrawer();
    } catch (e) {
      print("Erreur lors de l'ouverture de l'end drawer: $e");
    }
  }

  void onPageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  void onMenuChanged(String? value) {
    setState(() {
      _selectedMenu = value;
    });
  }

  void startSearch(BuildContext context) {
    showSearch(context: context, delegate: GenericSearchDelegate());
  }

  void toggleUpvote(int index) {
    setState(() {
      final post = communityPosts[index];
      if (post['isUpvoted']) {
        post['upvotes']--;
        post['isUpvoted'] = false;
      } else {
        post['upvotes']++;
        post['isUpvoted'] = true;
        if (post['isDownvoted']) {
          post['downvotes']--;
          post['isDownvoted'] = false;
        }
      }
    });
  }

  void toggleDownvote(int index) {
    setState(() {
      final post = communityPosts[index];
      if (post['isDownvoted']) {
        post['downvotes']--;
        post['isDownvoted'] = false;
      } else {
        post['downvotes']++;
        post['isDownvoted'] = true;
        if (post['isUpvoted']) {
          post['upvotes']--;
          post['isUpvoted'] = false;
        }
      }
    });
  }

  void showComments(BuildContext context, int index) {
    final post = communityPosts[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CommentSection(
        post: post,
        onAddComment: (comment) {
          setState(() {
            post['comments'].add(comment);
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void sharePost(BuildContext context, int index) {
    final post = communityPosts[index];
    final link = 'https://yourapp.com/post/${post['community']}/${index}';
    Share.share('Check out this post from ${post['community']}: $link');
  }

  void showFullImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.black87,
            child: InteractiveViewer(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showPostOptions(BuildContext context, int index) {
    final post = communityPosts[index];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.save, color: Colors.black),
                title: const Text('Enregistrer'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Publication enregistrée')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.block, color: Colors.black),
                title: const Text('Bloquer le compte'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Compte bloqué')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.report, color: Colors.black),
                title: const Text('Signaler'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Signalement envoyé')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.visibility_off, color: Colors.black),
                title: const Text('Cacher'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Publication cachée')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy, color: Colors.black),
                title: const Text('Copier le texte'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: post['content']));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Texte copié')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.black),
                title: const Text('Crospublier dans la communauté'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Publication partagée dans la communauté')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.red[900],
        colorScheme: ColorScheme.light(
          primary: Colors.red[900]!,
          secondary: Colors.black,
          background: Colors.white,
          surface: Colors.white,
        ),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: _selectedMenu,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                underline: const SizedBox(),
                onChanged: onMenuChanged,
                items: <String>['Accueil', 'Populaire', 'Regarder', 'Nouveauté']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(_getIconForMenu(value),
                            size: 20, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(value,
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  );
                }).toList(),
                hint: Image.asset('assets/esprit.png', height: 60),
              ),
            ],
          ),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => displayDrawer(context),
            );
          }),
          actions: [
            IconButton(
              onPressed: () => startSearch(context),
              icon: const Icon(Icons.search, color: Colors.black),
            ),
            Builder(builder: (context) {
              return IconButton(
                icon: const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/ameni.jpeg'), // Added Ameni's image
                ),
                onPressed: () => displayEndDrawer(context),
              );
            }),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: communityPosts.length,
                itemBuilder: (context, index) {
                  final post = communityPosts[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.red[900]!, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(post['avatar']),
                                radius: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                post['community'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.grey),
                                onPressed: () =>
                                    showPostOptions(context, index),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            post['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post['content'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          if (post['image'] != null) ...[
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () =>
                                  showFullImage(context, post['image']),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      post['image'],
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: Icon(
                                        Icons.zoom_in,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_upward,
                                      color: post['isUpvoted']
                                          ? Colors.red[900]
                                          : Colors.grey,
                                    ),
                                    onPressed: () => toggleUpvote(index),
                                  ),
                                  Text(
                                    '${post['upvotes']}',
                                    style: TextStyle(
                                      color: post['isUpvoted']
                                          ? Colors.red[900]
                                          : Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_downward,
                                      color: post['isDownvoted']
                                          ? Colors.red[900]
                                          : Colors.grey,
                                    ),
                                    onPressed: () => toggleDownvote(index),
                                  ),
                                  Text(
                                    '${post['downvotes']}',
                                    style: TextStyle(
                                      color: post['isDownvoted']
                                          ? Colors.red[900]
                                          : Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  IconButton(
                                    icon: const Icon(Icons.comment,
                                        color: Colors.grey),
                                    onPressed: () =>
                                        showComments(context, index),
                                  ),
                                  Text(
                                    '${post['comments'].length}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.share, color: Colors.grey),
                                onPressed: () => sharePost(context, index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        drawer: const CommunityListDrawer(),
        endDrawer: const ProfileDrawer(),
        backgroundColor: Colors.white,
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: _page,
          onTap: onPageChanged,
        ),
      ),
    );
  }

  IconData _getIconForMenu(String menu) {
    switch (menu) {
      case 'Accueil':
        return Icons.home;
      case 'Populaire':
        return Icons.trending_up;
      case 'Regarder':
        return Icons.visibility;
      case 'Nouveauté':
        return Icons.new_releases;
      default:
        return Icons.home;
    }
  }
}

class GenericSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> searchItems = [
    {'type': 'community', 'name': 'flutter', 'description': 'Technologie'},
    {
      'type': 'community',
      'name': 'wholesomememes',
      'description': 'Culture Internet'
    },
    {
      'type': 'post',
      'name': 'Flutter Tips',
      'description': 'A post about Flutter'
    },
    {'type': 'user', 'name': 'user1', 'description': 'A user profile'},
    {'type': 'community', 'name': 'buccaneers', 'description': 'Pop culture'},
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredItems = searchItems
        .where((item) =>
            item['name'].toLowerCase().contains(query.toLowerCase()) ||
            item['description'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Text(
                item['type'][0].toUpperCase(),
                style: TextStyle(color: Colors.red[900]),
              ),
            ),
            title: Text(
              item['name'],
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              '${item['type']} - ${item['description']}',
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              if (item['type'] == 'community') {
                Routemaster.of(context).push('/${item['name']}');
              }
              close(context, item['name']);
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  final Map<String, dynamic> post;
  final Function(String) onAddComment;

  const CommentSection(
      {super.key, required this.post, required this.onAddComment});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void addComment() {
    if (_commentController.text.isNotEmpty) {
      widget.onAddComment(_commentController.text);
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: Colors.red[900]!, width: 2),
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Commentaires (${widget.post['comments'].length})',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: widget.post['comments'].length,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.red[900]!, width: 0.5),
                      ),
                    ),
                    child: Text(
                      widget.post['comments'][index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Écrire un commentaire...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: IconButton(
                icon: Icon(Icons.send, color: Colors.red[900]),
                onPressed: addComment,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red[900]!, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red[900]!, width: 2),
              ),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: addComment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[900],
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Publier le commentaire'),
          ),
        ],
      ),
    );
  }
}
