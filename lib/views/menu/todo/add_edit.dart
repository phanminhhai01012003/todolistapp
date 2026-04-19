import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/common/utils.dart';
import 'package:todolistapp/models/todo.dart';
import 'package:todolistapp/services/firestore/todo/todo_services.dart';
import 'package:todolistapp/services/notification/notification_services.dart';
import 'package:todolistapp/widget/dialog.dart';
import 'package:todolistapp/widget/message.dart';

// ignore: must_be_immutable
class AddEdit extends StatefulWidget {
  TodoModel? todo;
  AddEdit({super.key, required this.todo});

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final _currentUser = FirebaseAuth.instance.currentUser!;
  TodoServices services = TodoServices();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
      dateController.text = DateFormat('dd-MM-yyyy').format(widget.todo!.endDate);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Commoncolor.black,
        foregroundColor: Commoncolor.white,
        leading: IconButton(
          onPressed: () {
            Platform.isAndroid ? ShowDialog.materialDialog(
              context, 
              title: "Discard Changes", 
              content: "Do you want to back to home without any changes?", 
              onAcceptTap: () async{
                pop(context);
                await Future.delayed(Duration(seconds: 1), () => pop(context));
              }, 
              onCancelTap: () => pop(context)
            ) : ShowDialog.cupertinoDialog(
              context, 
              title: "Discard Changes", 
              content: "Do you want to back to home without any changes?", 
              onAcceptTap: () async{
                pop(context);
                await Future.delayed(Duration(seconds: 1), () => pop(context));
              }, 
              onCancelTap: () => pop(context)
            );
          },
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text(widget.todo == null ? "Add Task" : "Edit Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title",
              style: TextStyle(
                color: Commoncolor.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Commoncolor.white,
                fontSize: 12,
                fontWeight: FontWeight.normal
              ),
              decoration: InputDecoration(
                prefixIcon: Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  child: Icon(Icons.title, color: Commoncolor.grey),
                ),
                hintText: "Enter title",
                hintStyle: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(color: Commoncolor.white)
                )
              ),
            ),
            SizedBox(height: 20),
            Text("Description",
              style: TextStyle(
                color: Commoncolor.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Commoncolor.white,
                fontSize: 12,
                fontWeight: FontWeight.normal
              ),
              maxLines: 3,
              minLines: 3,
              decoration: InputDecoration(
                prefixIcon: Container(
                  alignment: Alignment.center,
                  width: 20.w,
                  height: 20.h,
                  child: Icon(Icons.description, color: Commoncolor.grey),
                ),
                hintText: "Write description",
                hintStyle: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(color: Commoncolor.white)
                )
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Start Date:",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Text("Estimate end date",
              style: TextStyle(
                color: Commoncolor.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: dateController,
              style: TextStyle(
                color: Commoncolor.white,
                fontSize: 12,
                fontWeight: FontWeight.normal
              ),
              decoration: InputDecoration(
                prefixIcon: Container(
                  alignment: Alignment.center,
                  width: 20.w,
                  height: 20.h,
                  child: Icon(Icons.calendar_today, color: Commoncolor.grey),
                ),
                hintText: "Choose your estimate end date",
                hintStyle: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(color: Commoncolor.white)
                )
              ),
              readOnly: true,
              onTap: () async{
                DateTime? pickerDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(), 
                  lastDate: DateTime(2100),
                );
                if (pickerDate != null){
                  setState(() {
                    dateController.text = DateFormat('dd-MM-yyyy').format(pickerDate);
                  });
                }
              },
            ),
            SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: 50.h,
                width: (MediaQuery.of(context).size.width * 0.75).w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Commoncolor.blue,
                    foregroundColor: Commoncolor.white
                  ),
                  onPressed: () async{
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(Duration(seconds: 2));
                    if (isLoading) return;
                    if (titleController.text.isEmpty) {
                      Message.showMessage(context, "Task title is required", Commoncolor.red);
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }
                    if (dateController.text.isEmpty) {
                      Message.showMessage(context, "End date is required", Commoncolor.red);
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }   
                    TodoModel todo = TodoModel(
                      todoId: widget.todo == null ? generateRandomString(15) : widget.todo!.todoId, 
                      userId: widget.todo == null ? _currentUser.uid : widget.todo!.userId, 
                      title: titleController.text, 
                      description: descriptionController.text, 
                      startDate: widget.todo == null ? DateTime.now() : widget.todo!.startDate, 
                      endDate: DateFormat('dd-MM-yyyy').parse(dateController.text), 
                      status: "Progress",
                    );
                    widget.todo == null ? services.addTask(todo) : services.updateTask(todo);
                    setState(() {
                      isLoading = false;
                    });
                    Message.showMessage(context, widget.todo == null ? "New task has been created" : "Task has been updated", Commoncolor.green);
                    // scheduleTask(todo);           
                    pop(context);
                  }, 
                  child: isLoading 
                  ? Center(child: CircularProgressIndicator(color: Commoncolor.white))
                  : Text(widget.todo == null ? "Add" : "Edit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void scheduleTask(TodoModel todo) async{
    DateTime endDate = todo.endDate;
    DateTime scheduleDate = endDate.subtract(Duration(hours: 2));
    if (scheduleDate.isBefore(DateTime.now())) return;
    NotificationServices.scheduleNotification(
      title: "Nhiệm vụ sắp hết hạn", 
      body: "Nhiệm vụ ${todo.title} của bạn sẽ hết hạn vào $endDate, hãy nhanh chóng hoàn thành sớm nhất có thể", 
      time: scheduleDate
    );
  }
}