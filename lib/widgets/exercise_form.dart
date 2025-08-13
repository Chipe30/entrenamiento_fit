import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

void showExerciseForm(
  BuildContext context, {
  Map<String, dynamic>? initialData,
  String? docId,
}) {
  final TextEditingController nameController = TextEditingController(
    text: initialData?['name'] ?? '',
  );
  final TextEditingController descController = TextEditingController(
    text: initialData?['description'] ?? '',
  );
  final TextEditingController seriesController = TextEditingController(
    text: initialData?['series']?.toString() ?? '',
  );
  final TextEditingController repsController = TextEditingController(
    text: initialData?['repetitions']?.toString() ?? '',
  );
  String selectedDifficulty = initialData?['difficulty'] ?? 'Fácil';

  final FirebaseService firebaseService = FirebaseService();

  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(
            initialData == null ? "Agregar Ejercicio" : "Editar Ejercicio",
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Nombre"),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Descripción"),
                ),
                TextField(
                  controller: seriesController,
                  decoration: const InputDecoration(labelText: "Series"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: repsController,
                  decoration: const InputDecoration(labelText: "Repeticiones"),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  value: selectedDifficulty,
                  items:
                      ['Fácil', 'Intermedio', 'Avanzado']
                          .map(
                            (d) => DropdownMenuItem(value: d, child: Text(d)),
                          )
                          .toList(),
                  onChanged: (value) => selectedDifficulty = value!,
                  decoration: const InputDecoration(labelText: "Dificultad"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final data = {
                  'name': nameController.text,
                  'description': descController.text,
                  'series': int.tryParse(seriesController.text) ?? 0,
                  'repetitions': int.tryParse(repsController.text) ?? 0,
                  'difficulty': selectedDifficulty,
                };
                if (docId == null) {
                  firebaseService.addExercise(data);
                } else {
                  firebaseService.updateExercise(docId, data);
                }
                Navigator.pop(context);
              },
              child: Text(initialData == null ? "Guardar" : "Actualizar"),
            ),
          ],
        ),
  );
}
