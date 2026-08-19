import 'package:flutter/material.dart';
import '../models/meetup.dart';

class MeetupCard extends StatelessWidget {
  final Meetup meetup;
  final VoidCallback onTap;

  const MeetupCard({
    super.key,
    required this.meetup,
    required this.onTap,
  });

  IconData getIcon() {
    switch (meetup.deporte.toLowerCase()) {
      case "basket":
        return Icons.sports_basketball;

      case "futbol":
        return Icons.sports_soccer;

      case "tenis":
        return Icons.sports_tennis;

      case "running":
        return Icons.directions_run;

      default:
        return Icons.sports;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: ListTile(
        leading: Icon(
          getIcon(),
          color: Colors.deepOrange,
          size: 35,
        ),
        title: Text(
          meetup.deporte,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${meetup.lugar}\n${meetup.fecha} - ${meetup.hora}",
        ),
        trailing: Text(
          "${meetup.participantes}/${meetup.maxParticipantes}",
        ),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }
}