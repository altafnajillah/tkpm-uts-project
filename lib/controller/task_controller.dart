import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uts_app/model/task.dart';

class TaskController {
  final dbRef = FirebaseFirestore.instance
      .collection('tasks')
      .withConverter(
        fromFirestore:
            (snapshot, _) => Task(
              id: snapshot.id,
              subject: snapshot.data()!['subject'],
              subtitle: snapshot.data()!['subtitle'],
              desc: snapshot.data()!['desc'],
              deadline: snapshot.data()!['deadline'].toDate(),
            ),
        toFirestore:
            (task, _) => {
              'subject': task.subject,
              'subtitle': task.subtitle,
              'desc': task.desc,
              'deadline': task.deadline,
            },
      );

  Stream<List<Task>> getTasks() {
    return dbRef.orderBy('deadline').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> addTask(Task task) async {
    try {
      await dbRef.add(task);
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<Task?> getTaskById(String id) async {
    try {
      final doc = await dbRef.doc(id).get();
      if (doc.exists) {
        return doc.data();
      }
    } catch (e) {
      print('Error getting task: $e');
    }
    return null;
  }

  Future<void> updateTask(String id, Task task) async {
    try {
      await dbRef.doc(id).set(task);
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await dbRef.doc(id).delete();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
