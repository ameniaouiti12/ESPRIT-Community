import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'AddPostScreen.dart'; // Import the updated AddPostScreen
import 'HomeScreen.dart';    // Import the HomeScreen (assuming it's in a file named HomeScreen.dart)

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        // Prevent navigating to the same screen when already on it
        if (index == widget.currentIndex) return;

        switch (index) {
          case 0: // "Accueil" (Home) item
            Routemaster.of(context).push('/home');
            break;
          case 2: // "Créer" (Create) item
            Routemaster.of(context).push('/add-post');
            break;
          case 1:

          case 3:
            Routemaster.of(context).push('/discuter');// "Discuter" item

          case 4: // "Podcast" item
            widget.onTap(index); // Delegate to parent for custom navigation logic
            break;
        }
      },
      backgroundColor: Colors.grey[100], // Subtle grey background for consistency
      selectedItemColor: Colors.red[900], // Red for active items (matches app theme)
      unselectedItemColor: Colors.grey[600], // Slightly darker grey for inactive items
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold), // Bold labels for selected items
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal), // Normal weight for unselected
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed, // Ensures all icons are visible without shifting
      iconSize: 24, // Slightly larger icons for better visibility
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Communautés',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Créer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Discuter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mic), // Microphone icon for Podcast
          label: 'Podcast',
        ),
      ],
    );
  }
}