import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:esprit/Views/NavBar.dart'; // Import CustomNavigationBar (adjust path if needed)

class EditCommunityScreen extends StatefulWidget {
  final String name;
  const EditCommunityScreen({
    super.key,
    required this.name,
  });

  @override
  State<EditCommunityScreen> createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends State<EditCommunityScreen> {
  late TextEditingController _communityNameController;
  late TextEditingController _descriptionController;
  List<String> _selectedThemes = [];
  String? _communityType;
  bool _isLoading = false;

  // Mock community data
  final Map<String, dynamic> _mockCommunity = {
    'name': 'flutter',
    'description': 'Une communauté pour les passionnés de Flutter.',
    'themes': ['Technologie', 'Développement'],
    'type': 'Publique',
    'isSensitive': false,
  };

  // Liste des thèmes avec sous-catégories
  final Map<String, List<String>> _themes = {
    'Actualités et politique': ['Actualités', 'Activisme', 'Politique'],
    'Affaires et finances': [
      'Économie',
      'Crypto',
      'Offres et marché',
      'Startups et actualités entrepreneuriales',
      'Immobilier'
    ],
    'Anime et cosplay': ['Anime et Mangas', 'Cosplay'],
    'Art': ['Art'],
  };

  // Données statiques pour les images (placeholders)
  final Map<String, String> _mockImages = {
    'banner': 'https://via.placeholder.com/400x150',
    'avatar': 'assets/avatar.png',
  };

  // Constantes pour les styles
  static const _padding = EdgeInsets.all(16.0);
  static final _borderRadius = BorderRadius.circular(12);
  static final _inputDecorationBase = InputDecoration(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: _borderRadius,
      borderSide: BorderSide.none,
    ),
  );

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _communityNameController = TextEditingController(
      text: widget.name, // Use the passed community name
    );
    _descriptionController = TextEditingController(
      text: _mockCommunity['description'] ?? 'Description par défaut',
    );
    _selectedThemes = List<String>.from(_mockCommunity['themes'] ?? []);
    _communityType = _mockCommunity['type'] ?? 'Publique';
  }

  @override
  void dispose() {
    _communityNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _toggleTheme(String theme) {
    setState(() {
      if (_selectedThemes.contains(theme)) {
        _selectedThemes.remove(theme);
      } else if (_selectedThemes.length < 3) {
        _selectedThemes.add(theme);
      } else {
        _showSnackBar('Vous pouvez sélectionner jusqu’à 3 thèmes.');
      }
    });
  }

  void _setCommunityType(String? type) {
    setState(() {
      _communityType = type;
    });
  }

  Future<void> _saveChanges() async {
    if (_communityNameController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _communityType == null) {
      _showSnackBar('Veuillez remplir tous les champs obligatoires.');
      return;
    }

    if (_selectedThemes.any((theme) => !_themes.keys.contains(theme))) {
      _showSnackBar('Un ou plusieurs thèmes sélectionnés sont invalides.');
      return;
    }

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer les modifications'),
        content: const Text('Voulez-vous sauvegarder les changements ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child:
                const Text('Sauvegarder', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      final updatedCommunity = {
        'name': _communityNameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'themes': _selectedThemes,
        'type': _communityType,
      };

      _mockCommunity.addAll(updatedCommunity);

      await Future.delayed(const Duration(milliseconds: 500));
      setState(() => _isLoading = false);
      _showSnackBarWithAction('Communauté mise à jour avec succès !');
      Navigator.pop(context);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.contains('succès') ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSnackBarWithAction(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Fermer',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              image: DecorationImage(
                image: NetworkImage(_mockImages['banner']!),
                fit: BoxFit.cover,
                onError: (_, __) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: CircleAvatar(
              backgroundImage: AssetImage(_mockImages['avatar']!),
              radius: 32,
              onBackgroundImageError: (_, __) => const Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thèmes (max 3)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Thèmes sélectionnés ${_selectedThemes.length}/3'),
        const SizedBox(height: 8),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: _themes.keys.map((theme) {
            return CheckboxListTile(
              title: Tooltip(
                message: 'Sélectionner/désélectionner $theme',
                child: Text(theme),
              ),
              value: _selectedThemes.contains(theme),
              onChanged: (_) => _toggleTheme(theme),
              activeColor: Colors.red[900], // Changed to match theme
              checkColor: Colors.white,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCommunityTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Type de communauté',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...['Publique', 'Restreinte', 'Privée'].map((type) {
          return RadioListTile<String>(
            title: Tooltip(
              message: 'Changer le type de communauté en $type',
              child: Text(type),
            ),
            value: type,
            groupValue: _communityType,
            onChanged: _setCommunityType,
            subtitle: Text(
              type == 'Publique'
                  ? 'Tout le monde peut effectuer une recherche, voir et contribuer'
                  : type == 'Restreinte'
                      ? 'Tout le monde peut voir cette communauté, mais seuls les membres approuvés peuvent contribuer'
                      : 'Uniquement les membres approuvés peuvent voir et contribuer',
            ),
            activeColor: Colors.red[900], // Changed to match theme
          );
        }).toList(),
      ],
    );
  }

  void _navigateToHome(BuildContext context) {
    try {
      Routemaster.of(context).push('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de navigation: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => _navigateToHome(context), // Navigate to /home
        ),
        title: const Text(
          'Modifier la Communauté',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveChanges,
            child: const Text(
              'Sauvegarder',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
        backgroundColor: Colors.red[900], // Consistent with theme
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : Padding(
              padding: _padding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _communityNameController,
                      decoration: _inputDecorationBase.copyWith(
                        labelText: 'Nom de la communauté *',
                        prefixIcon: const Icon(Icons.edit),
                        fillColor:
                            isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      ),
                      maxLength: 21,
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      decoration: _inputDecorationBase.copyWith(
                        labelText: 'Description *',
                        prefixIcon: const Icon(Icons.description),
                        fillColor:
                            isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      ),
                      maxLength: 500,
                      maxLines: 5,
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    const SizedBox(height: 16),
                    _buildThemeSection(),
                    const SizedBox(height: 16),
                    _buildCommunityTypeSection(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 0, // Default to "Accueil"
        onTap: (index) {}, // Required but unused; navigation handled internally
      ),
    );
  }
}
