import 'package:flutter/material.dart';
import 'package:esprit/Views/NavBar.dart'; // Import CustomNavigationBar (adjust path if needed)
import 'package:routemaster/routemaster.dart'; // Required for navigation

class PodcastScreen extends StatelessWidget {
  const PodcastScreen({super.key});

  final List<PodcastHost> hosts = const [
    PodcastHost(
      name: "Ameni Aouiti",
      username: "@ameni_a",
      bio: "Experte en IA et technologie",
      listeners: 320,
      topic: "L'avenir de l'IA",
      duration: "45 min",
    ),
    PodcastHost(
      name: "Mohamed Borg",
      username: "@mborg",
      bio: "Spécialiste en développement",
      listeners: 280,
      topic: "Flutter avancé",
      duration: "60 min",
    ),
    PodcastHost(
      name: "Aziz Nasri",
      username: "@aziz_n",
      bio: "Designer UI/UX",
      listeners: 195,
      topic: "Design moderne",
      duration: "30 min",
    ),
    PodcastHost(
      name: "Mohamed Ali Trabelsi",
      username: "@mali_t",
      bio: "Entrepreneur tech",
      listeners: 410,
      topic: "Startup 101",
      duration: "50 min",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Naviguer vers la page d'accueil (Home) au lieu de simplement fermer l'écran
            Routemaster.of(context).push('/home');
          },
        ),
        title: const Text(
          "Podcasts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: hosts.length,
        itemBuilder: (context, index) {
          return PodcastHostTile(host: hosts[index]);
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 4, // Set to "Podcast" index
        onTap: (index) {}, // Required but unused; navigation handled internally
      ),
    );
  }
}

class PodcastHostTile extends StatelessWidget {
  final PodcastHost host;

  const PodcastHostTile({required this.host});

  void _showPodcastInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: Colors.red[900]!, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.red[900],
                            child: Text(
                              host.name[0],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 32),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                host.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                host.username,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow("Sujet", host.topic),
                            const SizedBox(height: 12),
                            _buildInfoRow("Bio", host.bio),
                            const SizedBox(height: 12),
                            _buildInfoRow("Durée", host.duration),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                                "Auditeurs", "${host.listeners} en ligne"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Participants",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 60,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildParticipantAvatar("A"),
                            _buildParticipantAvatar("M"),
                            _buildParticipantAvatar("A"),
                            _buildParticipantAvatar("M"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[900],
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PodcastRoomScreen(host: host),
                            ),
                          );
                        },
                        child: const Text(
                          "Rejoindre le podcast",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            color: Colors.red[900],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantAvatar(String initial) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.red[900],
        child: Text(
          initial,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red[900]!, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => _showPodcastInfo(context),
        leading: CircleAvatar(
          backgroundColor: Colors.red[900],
          radius: 25,
          child: Text(
            host.name[0],
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        title: Text(
          host.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${host.username} • ${host.topic}",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Icon(Icons.mic, color: Colors.red[900], size: 28),
      ),
    );
  }
}

class PodcastRoomScreen extends StatelessWidget {
  final PodcastHost host;

  const PodcastRoomScreen({required this.host});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[900],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      "${host.name}'s Live",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Icon(Icons.share, color: Colors.white),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.red[900],
                      child: Text(
                        host.name[0],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 48),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "EN DIRECT",
                      style: TextStyle(
                        color: Colors.red[900],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      host.topic,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${host.listeners} auditeurs en ligne",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mic, color: Colors.red[900], size: 30),
                        const SizedBox(width: 20),
                        Icon(Icons.headset, color: Colors.grey, size: 30),
                        const SizedBox(width: 20),
                        Icon(Icons.chat_bubble_outline,
                            color: Colors.grey, size: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Quitter le live",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PodcastHost {
  final String name;
  final String username;
  final String bio;
  final int listeners;
  final String topic;
  final String duration;

  const PodcastHost({
    required this.name,
    required this.username,
    required this.bio,
    required this.listeners,
    required this.topic,
    required this.duration,
  });
}
