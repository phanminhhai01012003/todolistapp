import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/models/todo.dart';
import 'package:todolistapp/services/firestore/todo/todo_services.dart';
import 'package:todolistapp/views/menu/todo/add_edit.dart';
import 'package:todolistapp/widget/dialog.dart';
import 'package:todolistapp/widget/info.dart';
import 'package:todolistapp/widget/message.dart';

class ProgressTaskDetail extends StatefulWidget {
  final TodoModel todo;
  const ProgressTaskDetail({super.key, required this.todo});

  @override
  State<ProgressTaskDetail> createState() => _ProgressTaskDetailState();
}

class _ProgressTaskDetailState extends State<ProgressTaskDetail> {
  final _service = TodoServices();
  void delete(BuildContext context, String id) async{
    _service.deleteTask(id);
    Message.showMessage(context, "You have removed this task", Commoncolor.green);
    Navigator.pop(context);
    await Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
  }
  void onCompletedTask() async{
    _service.updateTaskStatus(widget.todo.todoId, "Completed");
    Message.showMessage(context, "You have completed this task", Commoncolor.green);
    Navigator.pop(context);
    await Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Commoncolor.black,
      appBar: AppBar(
        backgroundColor: Commoncolor.black,
        foregroundColor: Commoncolor.white,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: Icon(Icons.arrow_back, size: 20)
          ),
        ),
        title: Text("Task Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Info(
              title: "Title:", 
              info: widget.todo.title
            ),
            SizedBox(height: 20),
            Info(
              title: "Description:", 
              info: widget.todo.description
            ),
            SizedBox(height: 20),
            Info(
              title: "Start Date:", 
              info: DateFormat("dd/mm/yyyy").format(widget.todo.startDate)
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("End Date:",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(widget.todo.endDate),
                      style: TextStyle(
                        color: Commoncolor.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    Text(
                      widget.todo.endDate.isBefore(DateTime.now()) 
                      ? "(Expired)" 
                      : "(${widget.todo.endDate.difference(DateTime.now()).inDays} days left)",
                      style: TextStyle(
                        color: widget.todo.endDate.isBefore(DateTime.now()) 
                        ? Commoncolor.red 
                        : Commoncolor.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal
                      ), 
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Task status:",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(widget.todo.status,
                  style: TextStyle(
                    backgroundColor: Commoncolor.yellow,
                    color: Commoncolor.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
            SizedBox(height: 55),
            SizedBox(
              height: 44.h,
              width: (MediaQuery.of(context).size.width * 0.8).w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Commoncolor.yellow,
                  foregroundColor: Commoncolor.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33))
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddEdit(todo: widget.todo)));
                },
                child: Text("Edit task", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 44.h,
              width: (MediaQuery.of(context).size.width * 0.8).w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Commoncolor.red,
                  foregroundColor: Commoncolor.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33))
                ),
                onPressed: () {
                  Platform.isAndroid ? ShowDialog.showMaterialDialog(
                    context, 
                    title: "Delete Task", 
                    content: "Are you sure to delete this task?", 
                    onAcceptTap: () => delete(context, widget.todo.todoId), 
                    onCancelTap: () => Navigator.pop(context)
                  ) : ShowDialog.showCupertinoDialog(
                    context, 
                    title: "Delete Task", 
                    content: "Are you sure to delete this task?", 
                    onAcceptTap: () => delete(context, widget.todo.todoId), 
                    onCancelTap: () => Navigator.pop(context)
                  );
                },
                child: Text("Delete task", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 44.h,
              width: (MediaQuery.of(context).size.width * 0.8).w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Commoncolor.green,
                  foregroundColor: Commoncolor.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33))
                ),
                onPressed: () {
                  Platform.isAndroid ? ShowDialog.showMaterialDialog(
                    context, 
                    title: "Mark as completed", 
                    content: "Are you sure that you have completed this task?", 
                    onAcceptTap: onCompletedTask, 
                    onCancelTap: () => Navigator.pop(context)
                  ) : ShowDialog.showCupertinoDialog(
                    context, 
                    title: "Mark as completed", 
                    content: "Are you sure that you have completed this task?", 
                    onAcceptTap: onCompletedTask, 
                    onCancelTap: () => Navigator.pop(context)
                  );
                },
                child: Text("Mark as completed", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}