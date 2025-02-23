import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

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
        if (index == widget.currentIndex) return;
        widget.onTap(index);

        switch (index) {
          case 0:
            Routemaster.of(context).push('/home');
            break;
          case 1: // Communities tab
            Routemaster.of(context)
                .push('/communities'); // New route for CommunityScreen
            break;
          case 2:
            Routemaster.of(context).push('/add-post');
            break;
          case 3:
            Routemaster.of(context).push('/discuter');
            break;
          case 4: // Podcast tab
            Routemaster.of(context)
                .push('/podcast'); // Navigate to PodcastScreen
            break;
          default:
            print('Navigation non implémentée pour cet index: $index');
        }
      },
      backgroundColor: Colors.grey[100],
      selectedItemColor: Colors.red[900],
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      iconSize: 24,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Communautés'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Créer'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Discuter'),
        BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Podcast'),
      ],
    );
  }
}
