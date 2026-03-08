import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Text("About",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/abyss.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                "Abyss Plan",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "App to do list that users can manage their "
                  "daily works through tasks that they need to do "
                  "and they can finish those tasks as soon as possible",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Version: 1.0.0",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}