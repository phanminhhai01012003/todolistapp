import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolistapp/common/commoncolor.dart';

class ShowDialog {
  static void showMaterialDialog(BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onAcceptTap,
    required VoidCallback onCancelTap
  }){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: Commoncolor.white,
        title: Text(title,
          style: TextStyle(
            color: Commoncolor.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(content,
          style: TextStyle(
            color: Commoncolor.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Commoncolor.blue,
              foregroundColor: Commoncolor.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
            ),
            onPressed: onAcceptTap,
            child: Text("Yes")
          ),
          TextButton(
            onPressed: onCancelTap, 
            child: Text("No", style: TextStyle(color: Commoncolor.black))
          )
        ],
      )
    );
  }
  static void showCupertinoDialog(BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onAcceptTap,
    required VoidCallback onCancelTap
  }){
    showDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: Text(title,
          style: TextStyle(
            color: Commoncolor.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold
          ),
        ),
        content: Text(content,
          style: TextStyle(
            color: Commoncolor.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: onAcceptTap,
            child: Text("Yes", style: TextStyle(color: Commoncolor.blue)),
          ),
          CupertinoDialogAction(
            onPressed: onCancelTap,
            child: Text("No", style: TextStyle(color: Commoncolor.red)),
          )
        ],
      )
    );
  }
}