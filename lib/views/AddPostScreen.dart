import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:image_picker/image_picker.dart';
import 'CommunitySearchScreen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String? _selectedCommunity = 'Sélectionner une communauté';
  bool _showPoll = false;
  List<TextEditingController> _pollOptions = [
    TextEditingController(text: 'Option 1'),
    TextEditingController(text: 'Option 2'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    for (var controller in _pollOptions) {
      controller.dispose();
    }
    super.dispose();
  }

  void _publishPost() {
    if (_selectedCommunity == 'Sélectionner une communauté' ||
        _titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Veuillez sélectionner une communauté et entrer un titre'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Publication réussie'),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  Future<void> _selectCommunity() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CommunitySearchScreen()),
    );
    if (result != null) {
      setState(() {
        _selectedCommunity = result;
      });
    }
  }

  // Pick images
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image sélectionnée : ${image.name}')),
      );
    }
  }

  // Pick videos
  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vidéo sélectionnée : ${video.name}')),
      );
    }
  }

  void _addPollOption() {
    setState(() {
      _pollOptions.add(
          TextEditingController(text: 'Option ${_pollOptions.length + 1}'));
    });
  }

  void _removePoll() {
    setState(() {
      _showPoll = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () {
            // Naviguer vers la page d'accueil (Home) au lieu de simplement fermer l'écran
            Routemaster.of(context).push('/home');
          },
        ),
        title: const Text(
          'Créer une publication',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: _publishPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Publier',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Community Selection
              GestureDetector(
                onTap: _selectCommunity,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedCommunity!,
                        style: TextStyle(
                          color: _selectedCommunity ==
                                  'Sélectionner une communauté'
                              ? Colors.grey[600]
                              : Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.black87),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title Input
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Titre',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red[900]!, width: 2),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Tags/Flair (Optional)
              Text(
                'Ajouter des étiquettes ou un flair (facultatif)',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 12),

              // Body Input
              TextField(
                controller: _bodyController,
                maxLines: 8,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Corps du texte (facultatif)',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red[900]!, width: 2),
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // Poll Section (appears when list icon is clicked)
              if (_showPoll) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sondage',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: _removePoll,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ..._pollOptions.map((controller) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _addPollOption,
                        child: Text(
                          '+ Ajouter une option au sondage',
                          style: TextStyle(color: Colors.red[900]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Formatting Icons with Professional Design
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Image Picker Icon
                  _buildIconButton(
                    icon: Icons.image,
                    tooltip: 'Ajouter une image',
                    onPressed: _pickImage,
                  ),
                  // Video Picker Icon
                  _buildIconButton(
                    icon: Icons.videocam,
                    tooltip: 'Ajouter une vidéo',
                    onPressed: _pickVideo,
                  ),
                  // Poll Icon
                  _buildIconButton(
                    icon: Icons.poll,
                    tooltip: 'Ajouter un sondage',
                    onPressed: () {
                      setState(() {
                        _showPoll = true;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build professional icon buttons
  Widget _buildIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, color: Colors.grey[700], size: 28),
        onPressed: onPressed,
        splashRadius: 24,
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(),
      ),
    );
  }
}
