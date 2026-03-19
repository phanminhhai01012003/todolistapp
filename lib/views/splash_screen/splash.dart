import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/views/menu/home/home_page.dart';
import 'package:todolistapp/views/splash_screen/no_internet.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool showLoading = false;
  String images = "assets/abyss.png";
  late StreamSubscription<List<ConnectivityResult>> subscription;
  Connectivity connectivity = Connectivity();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();    
  }
  void init(){
    Future.delayed(Duration(seconds: 5), (){
      setState(() {
        showLoading = true;
      });
    });
    Future.delayed(Duration(seconds: 10), (){
      checkInternet();
    });
  }
  void checkInternet(){
    subscription = connectivity.onConnectivityChanged.listen((result){
      if(result.contains(ConnectivityResult.none)){
        showNoInternetDialog(
          context, 
          onPressed: checkInternet
        );
      } else {
        pushAndRemoveUntil(context, HomePage());
      }
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
                child: Image.asset(
                  images,
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