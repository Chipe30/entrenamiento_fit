import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference exercises = FirebaseFirestore.instance.collection(
    'exercises',
  );

  Stream<QuerySnapshot> getExercises() {
    return exercises.snapshots();
  }

  Future<void> addExercise(Map<String, dynamic> data) async {
    await exercises.add(data);
  }

  Future<void> updateExercise(String id, Map<String, dynamic> data) async {
    await exercises.doc(id).update(data);
  }

  Future<void> deleteExercise(String id) async {
    await exercises.doc(id).delete();
  }
}
