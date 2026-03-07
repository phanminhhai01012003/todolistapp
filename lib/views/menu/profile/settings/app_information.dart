import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/views/menu/profile/widget/mode_select.dart';

class AppInformation extends StatefulWidget {
  const AppInformation({super.key});

  @override
  State<AppInformation> createState() => _AppInformationState();
}

class _AppInformationState extends State<AppInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("App information"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ModeSelect(
              icon: Icons.info_outline,
              title: "About", 
              onTap: (){}
            ),
            SizedBox(height: 5),
            ModeSelect(
              icon: Icons.rule,
              title: "Terms of use", 
              onTap: (){}
            ),
            SizedBox(height: 5),
            ModeSelect(
              icon: Icons.privacy_tip,
              title: "Privacy policy", 
              onTap: (){}
            ),
            SizedBox(height: 5),
            ModeSelect(
              icon: Icons.help,
              title: "Support", 
              onTap: (){}
            )
          ],
        ),
      ),
    );
  }
}