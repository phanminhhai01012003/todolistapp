import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/services/auth/auth_services.dart';
import 'package:todolistapp/views/authentication/changepassword/change_password.dart';
import 'package:todolistapp/views/authentication/login/login.dart';
import 'package:todolistapp/views/menu/profile/widget/show_user_inform.dart';
import 'package:todolistapp/widget/dialog.dart';
import 'package:todolistapp/widget/message.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _auth = AuthServices();
  void handleLogout(BuildContext context) async{
    await _auth.logOut(context);
    Message.showMessage(context, "Logout successful, now return to login", Commoncolor.green);
    pushAndRemoveUntil(context, Login());
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
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: ShowUserInform(),
          ),
          Divider(color: Commoncolor.grey, thickness: 1),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 50.h,
              width: (MediaQuery.of(context).size.width * 0.75).w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Commoncolor.yellow,
                  foregroundColor: Commoncolor.white
                ),
                onPressed: () {
                  push(context, ChangePassword());
                },
                child: Text("Change Password",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: SizedBox(
              height: 50.h,
              width: (MediaQuery.of(context).size.width * 0.75).w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Commoncolor.green,
                  foregroundColor: Commoncolor.white
                ),
                onPressed: () {
                  
                },
                child: Text("App Information",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: SizedBox(
              height: 50.h,
              width: (MediaQuery.of(context).size.width * 0.75).w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Commoncolor.red,
                  foregroundColor: Commoncolor.white
                ),
                onPressed: () {
                  Platform.isAndroid ? ShowDialog.showMaterialDialog(
                    context, 
                    title: "Log out", 
                    content: "Do you want to log out?", 
                    onAcceptTap: () => handleLogout(context), 
                    onCancelTap: () => pop(context)
                  ) : ShowDialog.showCupertinoDialog(
                    context, 
                    title: "Log out", 
                    content: "Do you want to log out?", 
                    onAcceptTap: () => handleLogout(context), 
                    onCancelTap: () => pop(context)
                  );
                },
                child: Text("Logout",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}