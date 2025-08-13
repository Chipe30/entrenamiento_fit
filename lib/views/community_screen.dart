import 'package:entrenamiento_fit/widgets/exercise_form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';
import '../widgets/exercise_timer.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(title: const Text('Recomendaciones Comunidad')),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.getExercises(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final exercises = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final doc = exercises[index];
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  title: Text(data['name'] ?? ''),
                  subtitle: Text(
                    'Series: ${data['series'] ?? 0}, Reps: ${data['repetitions'] ?? 0}, Dificultad: ${data['difficulty'] ?? ''}',
                  ),
                  children: [
                    if (data['duration'] != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ExerciseTimer(seconds: data['duration']),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showExerciseForm(
                              context,
                              initialData: data,
                              docId: doc.id,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            firebaseService.deleteExercise(doc.id);
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
