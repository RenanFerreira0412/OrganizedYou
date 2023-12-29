import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:organized_you/databases/db_firestore.dart';
import 'package:organized_you/models/task.dart';

class TaskController extends ChangeNotifier {
  final CollectionReference tasks = DBFirestore.get().collection('tasks');

  createTask(Task task) async {
    await tasks.add({
      "uid": task.uid,
      "title": task.title,
      "description": task.description,
      "is_finished": task.isFinished,
      "date": task.date,
      "category": task.category
    });
    notifyListeners();
  }

  updateTask(Task task, String? id) async {
    await tasks.doc(id).update({
      "uid": task.uid,
      "title": task.title,
      "description": task.description,
      "is_finished": task.isFinished,
      "date": task.date,
      "category": task.category
    });
    notifyListeners();
  }

  deleteTask(String? id) async {
    await tasks.doc(id).delete();
    notifyListeners();
  }

  updateStatus(String? id, bool isFinished) async {
    await tasks.doc(id).update({"is_finished": isFinished});
    notifyListeners();
  }
}
