import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/views/authentication/login/login.dart';

class ShowGuest extends StatelessWidget {
  const ShowGuest({super.key});

  @override
  Widget build(BuildContext context) {
    String defaultAvatar = "https://openclipart.org/image/2000px/247319";
    return GestureDetector(
      onTap: () {
        push(context, Login());
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
            color: Commoncolor.black,
            border: Border.all(color: Commoncolor.white)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  defaultAvatar,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Guest",
                    style: TextStyle(
                      color: Commoncolor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    "Click here to login",
                    style: TextStyle(
                      color: Commoncolor.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
            )
          ],
        ),
      ),
    );
  }
}