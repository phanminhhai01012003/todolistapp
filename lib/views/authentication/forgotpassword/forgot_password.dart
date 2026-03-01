import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/views/authentication/forgotpassword/handle_forgot_password.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  bool isLoading = false;
  bool get disableButton => emailController.text.isEmpty;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Commoncolor.black,
        appBar: AppBar(
          backgroundColor: Commoncolor.black,
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () => pop(context),
              child: Icon(Icons.arrow_back,
                color: Commoncolor.white,
                size: 30,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30),
                Text("Forgot Password",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 33,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20),
                Text("Fill your email below",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Commoncolor.white),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      child: Icon(Icons.email, color: Commoncolor.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide: BorderSide(color: Commoncolor.white)
                    ),
                    hintText: "Enter email",
                    hintStyle: TextStyle(
                      color: Commoncolor.white,
                      fontSize: 14
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // ignore: deprecated_member_use
                      backgroundColor: disableButton ? Commoncolor.blue.withOpacity(0.5) : Commoncolor.blue,
                      // ignore: deprecated_member_use
                      foregroundColor: disableButton ? Commoncolor.white.withOpacity(0.5) : Commoncolor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33),
                      ),
                    ),
                    onPressed: () {
                      var email = emailController.text;
                      if (disableButton) {
                        return;
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        HandleForgotPassword.handle(context, email);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: isLoading 
                    ? Center(child: CircularProgressIndicator(color: Commoncolor.white))
                    : Text("Send",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}