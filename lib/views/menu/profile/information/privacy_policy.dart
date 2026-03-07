import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
          title: Text("Privacy Policy",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Introduction",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to Abyss Plan." 
                "We are committed to protecting your personal information and privacy."
                "This policy explains how we collect, use, and protect your information when you use our app.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "2. Information collected",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We may collect the following types of data:\n" 
                "• Identifying information: Name, email address, phone number, date of birth (if you registered an account).\n"
                "• Device data: Device ID, operating system, IP address, and other technical information are collected automatically.\n"
                "• Device access permissions: Location (GPS), Camera, Photo Library (only when you grant permission to perform specific functions)",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "3. Purpose of using the information",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We use your information to:\n" 
                "• Provide and maintain the features of the application.\n"
                "• Personalize the user experience.\n"
                "• Send important notifications and support customers.\n"
                "• Detect and prevent fraudulent activities or security breaches.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "4. Share information with third parties",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We do not sell your data to third parties. However, we may share information with:\n" 
                "• Analytics services: Such as Google Analytics to understand how users interact with the app.\n"
                "• Legal authorities: When there is a lawful request from state agencies in accordance with the laws of Vietnam.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "5. Your rights regarding personal data",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "According to regulations, you have the following rights:\n" 
                "• Access and Edit: View and update personal information in the settings section.\n"
                "• Request deletion: You have the right to request the deletion of your account and all related data.\n"
                "• Withdrawing consent: You can turn off access permissions (location, camera) at any time in your phone settings.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "6. Data security",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We apply the necessary technical and organizational measures (such as SSL/TLS encryption)" 
                "to protect your data from unauthorized access.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "7. Change policy",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text( 
                "We may update this policy periodically. Any changes will be notified through the app or email.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "8. Contact",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text( 
                "If you have any questions, please contact us via:\n"
                "• Email: phanminhhai012003@gmail.com\n"
                "• Phone: 0984238803",
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