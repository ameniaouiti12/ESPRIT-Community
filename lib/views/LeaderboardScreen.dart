import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<User> users = [
    User(name: 'Iman', points: 2019),
    User(name: 'Vatani', points: 1932),
    User(name: 'Jonathan', points: 1431),
    User(name: 'Paul', points: 1241),
    User(name: 'Eve', points: 50),
  ];

  final List<User> topThreeUsers = [
    User(name: 'Iman', points: 2019),
    User(name: 'Vatani', points: 1932),
    User(name: 'Jonathan', points: 1431),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.red, // Définir la couleur primaire comme rouge
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Classement des Utilisateurs'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Podium(topThreeUsers: topThreeUsers),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserTile(user: users[index], rank: index + 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final int points;

  User({required this.name, required this.points});
}

class Podium extends StatelessWidget {
  final List<User> topThreeUsers;

  Podium({required this.topThreeUsers});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Podium de la Semaine',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPodiumPlace(context, topThreeUsers[1], 2),
              _buildPodiumPlace(context, topThreeUsers[0], 1),
              _buildPodiumPlace(context, topThreeUsers[2], 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumPlace(BuildContext context, User user, int rank) {
    Color medalColor;
    double elevation;

    switch (rank) {
      case 1:
        medalColor = Colors.amber;
        elevation = 8.0;
        break;
      case 2:
        medalColor = Colors.grey;
        elevation = 6.0;
        break;
      case 3:
        medalColor = Colors.brown;
        elevation = 4.0;
        break;
      default:
        medalColor = Colors.red;
        elevation = 2.0;
    }

    return Column(
      children: [
        CircleAvatar(
          backgroundColor: medalColor,
          radius: 30,
          child: Icon(
            Icons.emoji_events,
            color: Colors.white,
            size: 36,
          ),
        ),
        SizedBox(height: 8),
        Text(
          user.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'Points: ${user.points}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class UserTile extends StatelessWidget {
  final User user;
  final int rank;

  UserTile({required this.user, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: _buildMedal(context, rank),
        title: Text(
          user.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Points: ${user.points}',
          style: TextStyle(fontSize: 16),
        ),
        trailing: Icon(Icons.star, color: Theme.of(context).primaryColor),
      ),
    );
  }

  Widget _buildMedal(BuildContext context, int rank) {
    IconData medalIcon;
    Color medalColor;

    switch (rank) {
      case 1:
        medalIcon = Icons.emoji_events;
        medalColor = Colors.amber;
        break;
      case 2:
        medalIcon = Icons.emoji_events;
        medalColor = Colors.grey;
        break;
      case 3:
        medalIcon = Icons.emoji_events;
        medalColor = Colors.brown;
        break;
      default:
        return CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 20,
          child: Text(
            '$rank',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        );
    }

    return CircleAvatar(
      backgroundColor: medalColor,
      radius: 20,
      child: Icon(medalIcon, color: Colors.white, size: 24),
    );
  }
}
