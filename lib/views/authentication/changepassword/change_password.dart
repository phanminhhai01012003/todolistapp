import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/views/authentication/changepassword/handle_change_password.dart';
import 'package:todolistapp/widget/message.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isOldObscured = true, isNewObscured = true, isConfirmObscured = true;
  bool isLoading = false;
  bool get disableButton {
    return oldPasswordController.text.isEmpty || newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Commoncolor.black,
        appBar: AppBar(
          backgroundColor: Commoncolor.black,
          foregroundColor: Commoncolor.white,
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back,
                color: Commoncolor.white,
                size: 30,
              ),
            ),
          ),
          title: Text("Change Password"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Current password",
                    style: TextStyle(
                      color: Commoncolor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                SizedBox(height: 10),
                TextField(
                  controller: oldPasswordController,
                  obscureText: isOldObscured,
                  style: TextStyle(color: Commoncolor.white),
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        child: Icon(Icons.lock, color: Commoncolor.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide(color: Commoncolor.white)
                      ),
                      hintText: "Enter current password",
                      hintStyle: TextStyle(
                        color: Commoncolor.white,
                        fontSize: 14
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isOldObscured = !isOldObscured;
                          });
                        },
                        icon: Icon(
                          isOldObscured ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                          color: Commoncolor.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                Text("New password",
                    style: TextStyle(
                      color: Commoncolor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: newPasswordController,
                    obscureText: isNewObscured,
                    style: TextStyle(color: Commoncolor.white),
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        child: Icon(Icons.lock, color: Commoncolor.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide(color: Commoncolor.white)
                      ),
                      hintText: "Enter new password",
                      hintStyle: TextStyle(
                        color: Commoncolor.white,
                        fontSize: 14
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isNewObscured = !isNewObscured;
                          });
                        },
                        icon: Icon(
                          isNewObscured ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                          color: Commoncolor.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Confirm password",
                    style: TextStyle(
                      color: Commoncolor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: isConfirmObscured,
                    style: TextStyle(color: Commoncolor.white),
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        child: Icon(Icons.lock, color: Commoncolor.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide(color: Commoncolor.white)
                      ),
                      hintText: "Enter confirm password",
                      hintStyle: TextStyle(
                        color: Commoncolor.white,
                        fontSize: 14
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmObscured = !isConfirmObscured;
                          });
                        },
                        icon: Icon(
                          isConfirmObscured ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                          color: Commoncolor.grey,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 50),
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
                      onPressed: () async{
                        var oldPassword = oldPasswordController.text;
                        var newPassword = newPasswordController.text;
                        var confirmPassword = confirmPasswordController.text;
                        if (disableButton) {
                          return;
                        }else {
                          setState(() {
                            isLoading = true;
                          });
                          if (newPassword != confirmPassword) {
                            Message.showMessage(context, "Confirm password does not match!", Commoncolor.red);
                            setState(() {
                              isLoading = false;
                            });
                          }
                          HandleChangePassword.handle(
                            context,
                            email: currentUser.email,
                            oldPassword: oldPassword,
                            newPassword: newPassword
                          );
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading 
                      ? Center(child: CircularProgressIndicator(color: Commoncolor.white)) 
                      : Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        )
      ),
    );
  }
}