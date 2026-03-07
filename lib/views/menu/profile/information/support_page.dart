import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
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
          title: Text("Support",
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
              Text(
                "If anyone has any questions about this app, please contact via:",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Email: phanminhhai012003@gmail.com\n"
                  "Zalo: 0984238803",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}