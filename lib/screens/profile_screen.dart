import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi perfil"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.deepOrange,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Maximiliano",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Amante del deporte",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.sports_basketball),
                title: const Text("Deportes favoritos"),
                subtitle: const Text("Basket • Running"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.groups),
                title: const Text("Juntadas creadas"),
                subtitle: const Text("3"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.emoji_events),
                title: const Text("Participaciones"),
                subtitle: const Text("18"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text("Calificación"),
                subtitle: const Text("⭐ 4.9"),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text(
                  "Cerrar sesión",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}