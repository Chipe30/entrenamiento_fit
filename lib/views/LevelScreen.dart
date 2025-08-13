import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';
import '../widgets/exercise_form.dart';

class LevelScreen extends StatelessWidget {
  final String levelName; // 'Básico', 'Intermedio', 'Avanzado'

  const LevelScreen({super.key, required this.levelName});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(title: Text('Nivel $levelName')),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.getExercises(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          // Filtrar por dificultad
          final exercises =
              snapshot.data!.docs
                  .map(
                    (doc) =>
                        doc.data() as Map<String, dynamic>..['id'] = doc.id,
                  )
                  .where((e) => e['difficulty'] == levelName)
                  .toList();

          if (exercises.isEmpty)
            return const Center(
              child: Text('No hay ejercicios para este nivel'),
            );

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final item = exercises[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  title: Text(item['name']),
                  subtitle: Text(
                    'Series: ${item['series']}, Reps: ${item['repetitions']}',
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showExerciseForm(
                              context,
                              initialData: item,
                              docId: item['id'],
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            firebaseService.deleteExercise(item['id']);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showExerciseForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
