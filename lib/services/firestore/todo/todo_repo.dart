import 'package:todolistapp/models/todo.dart';

abstract class TodoRepo {
  Future<void> addTask(TodoModel task);
  Future<void> updateTask(TodoModel task);
  Future<void> updateTaskStatus(String id, String status);
  Future<void> deleteTask(String id);
}