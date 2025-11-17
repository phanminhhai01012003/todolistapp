import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolistapp/common/commoncolor.dart';

class Info extends StatelessWidget {
  final String title;
  final String info;
  const Info({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            color: Commoncolor.white,
            fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(
          width: 200,
          child: Expanded(
            child: Text(
              info,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 18.sp,
                color: Commoncolor.white,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        )
      ],
    );
  }
}