import 'package:flutter/material.dart';

import '../models/meetup.dart';
import '../widgets/meetup_card.dart';
import 'create_screen.dart';
import 'detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Meetup> meetups = [

    Meetup(
      deporte: "Basket",
      lugar: "Parque Centenario",
      fecha: "Hoy",
      hora: "19:00",
      participantes: 6,
      maxParticipantes: 10,
      descripcion: "Partido recreativo. Todos son bienvenidos.",
    ),

    Meetup(
      deporte: "Futbol",
      lugar: "Palermo",
      fecha: "Mañana",
      hora: "18:30",
      participantes: 12,
      maxParticipantes: 14,
      descripcion: "5 vs 5 + suplentes.",
    ),

    Meetup(
      deporte: "Running",
      lugar: "Puerto Madero",
      fecha: "Viernes",
      hora: "20:00",
      participantes: 4,
      maxParticipantes: 12,
      descripcion: "8 kilómetros tranquilos.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Text("Planazo"),
        actions: [

          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );

            },
          )

        ],
      ),

      body: ListView.builder(
        itemCount: meetups.length,
        itemBuilder: (context, index) {

          return MeetupCard(

            meetup: meetups[index],

            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(
                    meetup: meetups[index],
                  ),
                ),
              );

            },

          );

        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
        onPressed: () async {

          final Meetup? nueva = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateScreen(),
            ),
          );

          if (nueva != null) {
            setState(() {
              meetups.add(nueva);
            });
          }
        },
      ),

    );
  }
}