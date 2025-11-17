import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolistapp/common/commoncolor.dart';

class Message {
  static void showMessage(BuildContext context, String title, Color color){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: TextStyle(
            color: Commoncolor.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      )
    );
  }
}
