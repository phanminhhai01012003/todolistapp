import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/models/user.dart';
import 'package:todolistapp/views/menu/profile/details/edit_user.dart';
import 'package:todolistapp/widget/info.dart';

class UserDetail extends StatefulWidget {
  final UserModel user;
  const UserDetail({super.key, required this.user});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Commoncolor.black,
      appBar: AppBar(
        backgroundColor: Commoncolor.black,
        foregroundColor: Commoncolor.white,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: IconButton(
            onPressed: () => pop(context), 
            icon: Icon(Icons.arrow_back, size: 30)
          ),
        ),
        title: Text("User details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.network(widget.user.avatar,
                  fit: BoxFit.cover,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ),
            SizedBox(height: 20),
            Info(
              title: "User ID:",
              info: widget.user.userId,
            ),
            SizedBox(height: 20),
            Info(
              title: "Username:",
              info: widget.user.username,
            ),
            SizedBox(height: 20),
            Info(
              title: "Description:",
              info: widget.user.description,
            ),
            SizedBox(height: 20),
            Info(
              title: "Email:",
              info: widget.user.email,
            ),
            SizedBox(height: 55),
            Center(
              child: SizedBox(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Commoncolor.yellow,
                    foregroundColor: Commoncolor.white
                  ),
                  onPressed: () => push(context,EditUser(user: widget.user)),
                  child: Text("Edit Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}