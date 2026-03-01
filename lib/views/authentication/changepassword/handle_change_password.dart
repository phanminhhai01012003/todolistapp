import 'package:flutter/widgets.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/services/auth/auth_services.dart';
import 'package:todolistapp/widget/message.dart';

class HandleChangePassword {
  static final _auth = AuthServices();
  static void handle(BuildContext context, {email, oldPassword, newPassword}) async{
    await _auth.changePassword(
      context, 
      email: email,
      oldpassword: oldPassword,
      newPassword: newPassword
    );
    Message.showMessage(context, "Change Password Successful!", Commoncolor.green);
    pop(context);
  }
}