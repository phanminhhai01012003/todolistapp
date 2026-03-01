import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/models/user.dart';
import 'package:todolistapp/services/auth/auth_services.dart';
import 'package:todolistapp/services/firestore/user/user_services.dart';
import 'package:todolistapp/views/menu/home/home_page.dart';
import 'package:todolistapp/widget/message.dart';

class HandleRegister {
  static final _auth = AuthServices();
  static final services = UserServices();
  static void handle(BuildContext context, String avatar, String username, String email, String password) async{
    User? user = await _auth.register(context, avatar, username, email, password);
    if (user != null) {
      UserModel userModel = UserModel(
        userId: user.uid, 
        avatar: avatar, 
        description: "", 
        username: username, 
        email: email,
      );
      await services.addUser(userModel);
      Message.showMessage(context, "Register successful!", Commoncolor.green);
      pushAndRemoveUntil(context, HomePage());
    }else{
      Message.showMessage(context, "Register failed!", Commoncolor.red);
    }
  }
}