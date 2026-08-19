import 'package:flutter/material.dart';
import '../models/meetup.dart';

class DetailScreen extends StatelessWidget {
  final Meetup meetup;

  const DetailScreen({
    super.key,
    required this.meetup,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(meetup.deporte),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Icon(
                getIcon(),
                size: 90,
                color: Colors.deepOrange,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              meetup.deporte,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 10),
                Text(
                  meetup.lugar,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 10),
                Text(
                  "${meetup.fecha} - ${meetup.hora}",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const Icon(Icons.people),
                const SizedBox(width: 10),
                Text(
                  "${meetup.participantes}/${meetup.maxParticipantes} participantes",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Descripción",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              meetup.descripcion,
              style: const TextStyle(fontSize: 18),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text(
                  "Unirme",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("¡Te uniste a la actividad!"),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}