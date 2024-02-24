import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addTask({
    required String title,
    required String notes,
    required String remind,
    required String date,
    required String time,
    required int color,
  }) async {
    var taskId = const Uuid().v1();

    var task = TaskModel(
      taskId: taskId,
      title: title,
      notes: notes,
      remind: remind,
      date: date,
      time: time,
      color: color,
    );

    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .set(task.toMap());
  }

  Stream<List<TaskModel>> getTaskList() {
    return firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .orderBy('time', descending: true)
        .snapshots()
        .map((event) {
      List<TaskModel> taskList = [];
      for (var document in event.docs) {
        taskList.add(TaskModel.fromMap(document.data()));
      }
      return taskList;
    });
  }

// delete task
  void deleteTask({required taskId}) {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .delete()
        .then((value) => print("Task Deleted"));
  }

// update task
  void updateTask({
    required String taskId,
    required String title,
    required String notes,
    required String remind,
    required String date,
    required String time,
    required int color,
  }) async {
    var task = TaskModel(
      taskId: taskId,
      title: title,
      notes: notes,
      remind: remind,
      date: date,
      time: time,
      color: color,
    );

    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .update(task.toMap());
  }
}
