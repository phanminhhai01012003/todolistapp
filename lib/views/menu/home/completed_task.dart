import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/models/todo.dart';
import 'package:todolistapp/services/firestore/todo/todo_services.dart';
import 'package:todolistapp/views/menu/todo/completed_task_detail.dart';

class CompletedTask extends StatefulWidget {
  final bool isGrid;
  const CompletedTask({super.key, required this.isGrid});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  final _todoService = TodoServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _todoService.getUserTask("Completed"),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Icon(Icons.error, size: 20, color: Commoncolor.white),
                SizedBox(height: 10),
                Text(
                  "No data",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Commoncolor.white),
          );
        } else {
          List<TodoModel> todos = snapshot.data!;
          return widget.isGrid ? todoGrid(todos) : todoList(todos);
        }
      },
    );
  }

  Widget todoList(List<TodoModel> todos) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        TodoModel todo = todos[index];
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Commoncolor.green,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Commoncolor.white),
          ),
          child: ListTile(
            onTap: () => push(context, CompletedTaskDetail(todo: todo)),
            title: Text(
              todo.title,
              style: TextStyle(
                fontSize: 18,
                color: Commoncolor.white,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text(
              todo.description,
              style: TextStyle(
                fontSize: 14,
                color: Commoncolor.white,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: Text(
              DateFormat('dd/MM/yyyy').format(todo.startDate),
              style: TextStyle(
                fontSize: 16,
                color: Commoncolor.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget todoGrid(List<TodoModel> todos) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.78,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        TodoModel todo = todos[index];
        return GestureDetector(
          onTap: () => push(context, CompletedTaskDetail(todo: todo)),
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Commoncolor.green,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Commoncolor.white),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Commoncolor.white,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    todo.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Commoncolor.white,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    DateFormat('dd/MM/yyyy').format(todo.startDate),
                    style: TextStyle(
                      fontSize: 16,
                      color: Commoncolor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
