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
          title: Text("Terms of use",
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
                "1. Accept the Terms",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "By downloading, installing, or using the Abyss Plan app, you agree to be bound by these terms."
                "If you do not agree, please stop using and uninstall the app immediately.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "2. User Account",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "• Registration: You must provide accurate and complete information when creating an account.\n"
                "• Security: You are responsible for keeping your password and all activity under your account secure. From January 1, 2025, applications (especially financial ones) may have their remember password feature restricted to enhance security.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "3. Intellectual property rights",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "All content, logos, designs, and source code of the application are owned by Abyss Plan." 
                "You are granted limited, non-exclusive, and non-transferable rights to use them." ,
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "4. Prohibited behavior",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Users are not allowed to:\n" 
                "• Copy, modify, or reverse engineer the application.\n"
                "• Using the app for illegal purposes or infringing on the rights of others.\n"
                "• Spreading viruses or malware that harm the system.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "5. Limitation of liability",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "The application is provided as is."
                "We are not liable for any direct or indirect damages arising from your use or inability to use the application.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "6. Updates and Termination",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                "• Updates: We reserve the right to update or change app features without prior notice to fix bugs or improve the user experience.\n" 
                "• Termination: We reserve the right to temporarily suspend or delete your account if we detect a violation of these terms.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "7. Privacy policy",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text( 
                "The collection and use of your personal data are detailed in our app."
                "We are committed to complying with regulations regarding the protection of consumer personal information.",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 10),
              Text(
                "8. Applicable Law and Dispute Resolution",
                style: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text( 
                "Any disputes arising will be governed by the laws of the Socialist Republic of Vietnam and resolved in the competent court.",
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