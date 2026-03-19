import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/services/auth/auth_services.dart';
import 'package:todolistapp/services/firestore/todo/todo_services.dart';
import 'package:todolistapp/views/menu/home/home_page.dart';
import 'package:todolistapp/widget/message.dart';

class HandleLogin {
  static final _auth = AuthServices();
  static final todos = TodoServices();
  static void handle(BuildContext context, String email, String password) async{
    User? user = await _auth.login(context, email, password);
    if (user != null){
      await todos.syncLocalTaskToFirestore();
      Message.showMessage(context, "Login successful!", Commoncolor.green);
      pushAndRemoveUntil(context, HomePage());
    } else {
      Message.showMessage(context, "Login Failed!", Commoncolor.red);
    }
  }
}
