import 'package:flutter/material.dart';
import '../models/meetup.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final deporteController = TextEditingController();
  final lugarController = TextEditingController();
  final fechaController = TextEditingController();
  final horaController = TextEditingController();
  final descripcionController = TextEditingController();

  final participantesController = TextEditingController(text: "1");
  final maxController = TextEditingController(text: "10");

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Crear juntada"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: deporteController,
              decoration: const InputDecoration(
                labelText: "Deporte",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.sports),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: lugarController,
              decoration: const InputDecoration(
                labelText: "Lugar",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: "Fecha",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: horaController,
              decoration: const InputDecoration(
                labelText: "Hora",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time),
              ),
            ),

            const SizedBox(height: 15),

            Row(

              children: [

                Expanded(
                  child: TextField(
                    controller: participantesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Actuales",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: TextField(
                    controller: maxController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Máximo",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descripcionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Descripción",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(

                icon: const Icon(Icons.add),

                label: const Text(
                  "Crear juntada",
                  style: TextStyle(fontSize: 18),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {

                  final meetup = Meetup(

                    deporte: deporteController.text,

                    lugar: lugarController.text,

                    fecha: fechaController.text,

                    hora: horaController.text,

                    participantes:
                        int.tryParse(participantesController.text) ?? 1,

                    maxParticipantes:
                        int.tryParse(maxController.text) ?? 10,

                    descripcion: descripcionController.text,

                  );

                  Navigator.pop(context, meetup);

                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}