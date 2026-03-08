import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/models/todo.dart';
import 'package:todolistapp/services/firestore/todo/todo_services.dart';
import 'package:todolistapp/widget/info.dart';
import 'package:todolistapp/widget/message.dart';

class CompletedTaskDetail extends StatefulWidget {
  final TodoModel todo;
  const CompletedTaskDetail({super.key, required this.todo});

  @override
  State<CompletedTaskDetail> createState() => _CompletedTaskDetailState();
}

class _CompletedTaskDetailState extends State<CompletedTaskDetail> {
  final _service = TodoServices();
  void delete(BuildContext context, String id) async{
    _service.deleteTask(id);
    Message.showMessage(context, "You have removed this task", Commoncolor.green);
    pop(context);
    await Future.delayed(Duration(seconds: 1), ()=> pop(context));
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
            onPressed: () => pop(context), 
            icon: Icon(Icons.arrow_back, size: 20)
          ),
        ),
        title: Text("Task Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
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
              info: DateFormat("dd/MM/yyyy").format(widget.todo.startDate)
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
                        color: widget.todo.endDate.isBefore(DateTime.now()) ? Commoncolor.red : Commoncolor.white,
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
                    backgroundColor: Commoncolor.green,
                    color: Commoncolor.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
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
                  delete(context, widget.todo.todoId);
                },
                child: Text("Delete task", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}