import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/views/authentication/login/login.dart';
import 'package:todolistapp/views/authentication/register/handle_register.dart';
import 'package:todolistapp/widget/message.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool isPasswordObscured = true, isConfirmObscured = true;
  bool isLoading = false;
  bool get disableButton{
    return nameController.text.isEmpty || 
      emailController.text.isEmpty || 
      passwordController.text.isEmpty || 
      confirmController.text.isEmpty;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Commoncolor.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Are you a new one?",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                Text("Please fill informations below",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900
                  ),
                ),
                SizedBox(height: 33),
                Text("Full Name",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  style: TextStyle(color: Commoncolor.white),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      child: Icon(Icons.person, color: Commoncolor.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide: BorderSide(color: Commoncolor.white)
                    ),
                    hintText: "Enter your name",
                    hintStyle: TextStyle(
                      color: Commoncolor.white,
                      fontSize: 14
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                Text("Email",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
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
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                Text("Password",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: isPasswordObscured,
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
                    hintText: "Enter password",
                    hintStyle: TextStyle(
                      color: Commoncolor.white,
                      fontSize: 14
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordObscured = !isPasswordObscured;
                        });
                      },
                      icon: Icon(
                        isPasswordObscured ? Icons.visibility : Icons.visibility_off,
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
                  controller: confirmController,
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
                    onPressed: () {
                      var avatar = "https://openclipart.org/image/2000px/247319";
                      var name = nameController.text;
                      var email = emailController.text;
                      var password = passwordController.text;
                      var confirm = confirmController.text;
                      if (disableButton) {
                        return;
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        if (password != confirm){
                          Message.showMessage(context, "Password do not match", Commoncolor.red);
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }else{
                          setState(() {
                            isLoading = false;
                          });
                          HandleRegister.handle(context, avatar, name, email, password);
                        }
                      }                      
                    },
                    child: isLoading 
                    ? Center(child: CircularProgressIndicator(color: Commoncolor.white))
                    : Text("Confirm",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Commoncolor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      TextButton(
                        onPressed: () => push(context, Login()),
                        child: Text(
                          "Login now!",
                          style: TextStyle(
                            color: Commoncolor.white,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
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