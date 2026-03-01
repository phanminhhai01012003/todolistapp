import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/views/authentication/login/login.dart';
import 'package:todolistapp/views/menu/home/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool showLoading = false;
  final _auth = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), (){
      setState(() {
        showLoading = true;
      });
    });
    Future.delayed(Duration(seconds: 10), (){
      pushAndRemoveUntil(
        context, 
         _auth != null ? HomePage() : Login() 
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Commoncolor.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                duration: Duration(seconds: 2),
                child: Image.asset("assets/abyss.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              if (showLoading) CircularProgressIndicator(color: Commoncolor.white)
            ],
          ),
        ),
      ),
    );
  }
}