import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolistapp/models/todo.dart';
import 'package:todolistapp/services/firestore/todo/todo_repo.dart';

class TodoServices extends TodoRepo{
  final todoCollection = FirebaseFirestore.instance.collection("todo");
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Future<void> addTask(TodoModel task) async{
    // TODO: implement addTask
    try {
      return await todoCollection.doc(task.todoId).set(task.toJson());
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String id) async{
    // TODO: implement deleteTask
    try {
      return await todoCollection.doc(id).delete();
    } catch (e) {
      print("Error: $e");
      rethrow;
    }   
  }

  @override
  Future<void> updateTask(TodoModel task) async{
    // TODO: implement updateTask
    try {
      return await todoCollection.doc(task.todoId).update(task.updateJson());
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateTaskStatus(String id, String status) async{
    // TODO: implement updateTaskStatus
    try {
      return await todoCollection.doc(id).update({"status": status});
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Stream<List<TodoModel>> getUserTask(String status){
    try {
      return todoCollection
        .where("userId", isEqualTo: user.uid)
        .where("status", isEqualTo: status)
        .snapshots()
        .map((event) => event.docs.map((doc) => TodoModel.fromJson(doc.data())).toList());
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}