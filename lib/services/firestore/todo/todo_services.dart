import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:todolistapp/models/todo.dart';
import 'package:todolistapp/services/firestore/todo/todo_repo.dart';

class TodoServices extends TodoRepo{
  final todoCollection = FirebaseFirestore.instance.collection("todo");
  final user = FirebaseAuth.instance.currentUser;
  var box = Hive.box("tasks_box");
  @override
  Future<void> addTask(TodoModel task) async{
    // TODO: implement addTask
    try {
      if (user != null) {
        await todoCollection.doc(task.todoId).set(task.toJson());
      } else {
        await box.put(task.todoId, task.toJson());
      }      
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String id) async{
    // TODO: implement deleteTask
    try {
      if (user != null) {
        await todoCollection.doc(id).delete();
      } else {
        await box.delete(id);
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }   
  }

  @override
  Future<void> updateTask(TodoModel task) async{
    // TODO: implement updateTask
    try {
      if (user != null) {
        await todoCollection.doc(task.todoId).update(task.updateJson());
      } else {
        box.put(task.todoId, task.updateJson());
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateTaskStatus(String id, String status) async{
    // TODO: implement updateTaskStatus
    try {
      if (user != null) {
        await todoCollection.doc(id).update({"status": status});
      } else {
        box.put(id, {"status": status});
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Stream<List<TodoModel>> getUserTask(String status){
    try {
      if (user != null) {
        return todoCollection
          .where("userId", isEqualTo: user!.uid)
          .where("status", isEqualTo: status)
          .snapshots()
          .map((event) => event.docs.map((doc) => TodoModel.fromJson(doc.data())).toList());
      } else {
        return Stream.value(box.values
          .where((element) => element["status"] == status)
          .map((e) => TodoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList());
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> syncLocalTaskToFirestore() async{
    try {
      if (user == null) return;
      if (box.isEmpty) return;
      final firestore = FirebaseFirestore.instance;
      final batch = firestore.batch();
      for (var key in box.keys){
        batch.set(todoCollection.doc(), Map<String, dynamic>.from(key));
      }
      await batch.commit();
      await box.clear();
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}