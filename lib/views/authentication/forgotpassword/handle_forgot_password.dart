import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/services/auth/auth_services.dart';
import 'package:todolistapp/widget/message.dart';

class HandleForgotPassword {
  static final _auth = AuthServices();
  static void handle(BuildContext context, String email) async {
    await _auth.resetPassword(context, email);
    Message.showMessage(context, "A password reset link sent to your email", Commoncolor.green);
    pop(context);
  }
}