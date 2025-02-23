import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:esprit/Views/NavBar.dart'; // Import CustomNavigationBar (adjust path if needed)

class CreateCommunityScreen extends StatefulWidget {
  final int step; // Current step (1, 2, or 3)
  final String? communityName;
  final String? description;
  final List<String>? selectedThemes;
  final String? communityType; // Community type (Public, Restricted, Private)
  final bool? isSensitive; // Sensitive content option (18+)

  const CreateCommunityScreen({
    super.key,
    this.step = 1,
    this.communityName,
    this.description,
    this.selectedThemes,
    this.communityType,
    this.isSensitive,
  });

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController communityNameController;
  late TextEditingController descriptionController;
  List<String> selectedThemes = [];
  String? communityType;
  bool isSensitive = false;
  bool isLoading = false;
  late AnimationController _animationController;

  // List of themes with subcategories
  final Map<String, List<String>> themes = {
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    communityNameController =
        TextEditingController(text: widget.communityName ?? '');
    descriptionController =
        TextEditingController(text: widget.description ?? '');
    selectedThemes = widget.selectedThemes ?? [];
    communityType = widget.communityType;
    isSensitive = widget.isSensitive ?? false;
  }

  @override
  void dispose() {
    communityNameController.dispose();
    descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void navigateToNextStep() {
    if (widget.step == 1) {
      String communityName = communityNameController.text.trim();
      String description = descriptionController.text.trim();

      if (communityName.isEmpty || description.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Veuillez remplir le nom et la description de la communauté.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() => isLoading = true);

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() => isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateCommunityScreen(
              step: 2,
              communityName: communityName,
              description: description,
            ),
          ),
        );
      });
    } else if (widget.step == 2) {
      if (selectedThemes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner au moins un thème.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() => isLoading = true);

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() => isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateCommunityScreen(
              step: 3,
              communityName: widget.communityName,
              description: widget.description,
              selectedThemes: selectedThemes,
            ),
          ),
        );
      });
    } else if (widget.step == 3) {
      if (communityType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner un type de communauté.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() => isLoading = true);

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() => isLoading = false);

        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Communauté créée avec succès !'),
            backgroundColor: Colors.green,
          ),
        );

        // Naviguer vers la page de la communauté (CommunityPage)
        Routemaster.of(context).push('/community');
      });
    }
  }

  void toggleTheme(String theme) {
    setState(() {
      if (selectedThemes.contains(theme)) {
        selectedThemes.remove(theme);
      } else if (selectedThemes.length < 3) {
        selectedThemes.add(theme);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vous pouvez sélectionner jusqu’à 3 thèmes.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void setCommunityType(String? type) {
    setState(() {
      communityType = type;
    });
  }

  void toggleSensitive(bool value) {
    setState(() {
      isSensitive = value;
    });
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => _navigateToHome(context), // Navigate to /home
        ),
        title: Text(
          '${widget.step} sur 3',
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: isLoading ? null : navigateToNextStep,
            child: const Text(
              'Suivant',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : FadeTransition(
              opacity: CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.step == 1) ...[
                        const Text(
                          'Parle-nous de ta communauté',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Un nom et une description aident les utilisateurs à comprendre ta communauté.',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: communityNameController,
                          decoration: InputDecoration(
                            labelText: 'Nom de la communauté *',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLength: 21,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description *',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLength: 500,
                          maxLines: 5,
                        ),
                      ] else if (widget.step == 2) ...[
                        const Text(
                          'Choisis les thèmes de ta communauté',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Ajoute jusqu’à 3 thèmes pour aider les utilisateurs à trouver ta communauté.',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        Text('Thèmes sélectionnés ${selectedThemes.length}/3'),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 300,
                          child: ListView(
                            children: themes.entries.map((entry) {
                              return CheckboxListTile(
                                title: Text(entry.key),
                                value: selectedThemes.contains(entry.key),
                                onChanged: (_) => toggleTheme(entry.key),
                              );
                            }).toList(),
                          ),
                        ),
                      ] else if (widget.step == 3) ...[
                        const Text(
                          'Sélectionner le type de communauté',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Décide qui peut consulter et contribuer à ta communauté. Seules les communautés publiques apparaissent dans la recherche. Important : une fois le type de ta communauté défini, tu ne pourras le modifier qu’avec l’approbation de Reddit.',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        RadioListTile<String>(
                          title: const Text('Publique'),
                          value: 'Publique',
                          groupValue: communityType,
                          onChanged: setCommunityType,
                          subtitle: const Text(
                              'Tout le monde peut effectuer une recherche, voir et contribuer'),
                        ),
                        RadioListTile<String>(
                          title: const Text('Restreinte'),
                          value: 'Restreinte',
                          groupValue: communityType,
                          onChanged: setCommunityType,
                          subtitle: const Text(
                              'Tout le monde peut voir cette communauté, mais les personnes qui peuvent contribuer...'),
                        ),
                        RadioListTile<String>(
                          title: const Text('Privée'),
                          value: 'Privée',
                          groupValue: communityType,
                          onChanged: setCommunityType,
                          subtitle: const Text(
                              'Uniquement les membres approuvés peuvent la voir et y contribuer'),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
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
