import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:esprit/Views/NavBar.dart'; // Import CustomNavigationBar (adjust path if needed)

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  bool _isLoading = false;

  // Mock profile data
  final Map<String, dynamic> _mockProfile = {
    'username': 'Tiny-Process-2200',
    'bio': 'Utilisateur passionné de technologie',
    'email': 'tiny.process@example.com',
    'age': '25',
  };

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
    _usernameController = TextEditingController(text: _mockProfile['username']);
    _bioController = TextEditingController(text: _mockProfile['bio']);
    _emailController = TextEditingController(text: _mockProfile['email']);
    _ageController = TextEditingController(text: _mockProfile['age']);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_usernameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _ageController.text.trim().isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs obligatoires.');
      return;
    }

    // Basic email validation
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
        .hasMatch(_emailController.text.trim())) {
      _showSnackBar('Veuillez entrer un email valide.');
      return;
    }

    // Basic age validation (numeric and reasonable range)
    final age = int.tryParse(_ageController.text.trim());
    if (age == null || age < 13 || age > 120) {
      _showSnackBar('Veuillez entrer un âge valide (13-120).');
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
                const Text('Sauvegarder', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      final updatedProfile = {
        'username': _usernameController.text.trim(),
        'bio': _bioController.text.trim(),
        'email': _emailController.text.trim(),
        'age': _ageController.text.trim(),
      };

      _mockProfile.addAll(updatedProfile);

      await Future.delayed(const Duration(milliseconds: 500));
      setState(() => _isLoading = false);
      _showSnackBarWithAction('Profil mis à jour avec succès !');
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
        backgroundColor: Colors.red[900],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => _navigateToHome(context), // Navigate to /home
        ),
        title: const Text(
          'Éditer Profil',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveChanges,
            child: const Text(
              'Sauvegarder',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : Padding(
              padding: _padding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informations du Profil',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _usernameController,
                      decoration: _inputDecorationBase.copyWith(
                        labelText: 'Nom d’utilisateur *',
                        prefixIcon: const Icon(Icons.person),
                        fillColor: Colors.grey[200],
                      ),
                      maxLength: 20,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: _inputDecorationBase.copyWith(
                        labelText: 'Email *',
                        prefixIcon: const Icon(Icons.email),
                        fillColor: Colors.grey[200],
                      ),
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 50,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _ageController,
                      decoration: _inputDecorationBase.copyWith(
                        labelText: 'Âge *',
                        prefixIcon: const Icon(Icons.cake),
                        fillColor: Colors.grey[200],
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _bioController,
                      decoration: _inputDecorationBase.copyWith(
                        labelText: 'Bio',
                        prefixIcon: const Icon(Icons.info),
                        fillColor: Colors.grey[200],
                      ),
                      maxLength: 150,
                      maxLines: 3,
                    ),
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
