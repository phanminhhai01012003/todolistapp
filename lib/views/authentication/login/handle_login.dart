import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/services/auth/auth_services.dart';
import 'package:todolistapp/views/menu/home/home_page.dart';
import 'package:todolistapp/widget/message.dart';

class HandleLogin {
  final _auth = AuthServices();
  void handle(BuildContext context, String email, String password) async{
    User? user = await _auth.login(context, email, password);
    if (user != null){
      Message.showMessage(context, "Login successful!", Commoncolor.green);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
    }
  }
}
