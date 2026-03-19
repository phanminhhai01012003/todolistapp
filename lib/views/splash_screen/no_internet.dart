import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';

void showNoInternetDialog(BuildContext context, {required VoidCallback onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Commoncolor.black.withValues(alpha: 0.5),
    builder: (context) => Dialog(
      backgroundColor: Commoncolor.white,
      surfaceTintColor: Commoncolor.white,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetAnimationCurve: Easing.legacyAccelerate,
      insetAnimationDuration: Duration(milliseconds: 200),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Icon(Icons.wifi_off, color: Commoncolor.red),
          ),
          SizedBox(height: 30),
          Text("No internet",
            style: TextStyle(
              color: Commoncolor.black,
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 5),
          Text("Please check your internet connection and try again",
            style: TextStyle(
              color: Commoncolor.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.75,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Commoncolor.green,
                foregroundColor: Commoncolor.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33))
              ),
              child: Text("Try again",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                ),
              )
            ),
          )
        ],
      ),
    )
  );
}