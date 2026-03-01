import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/models/user.dart';
import 'package:todolistapp/services/firestore/user/user_services.dart';
import 'package:todolistapp/services/storage/storage_services.dart';
import 'package:todolistapp/views/menu/profile/details/show_image_picker_modal.dart';
import 'package:todolistapp/widget/message.dart';

// ignore: must_be_immutable
class EditUser extends StatefulWidget {
  UserModel? user;
  EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final currUser = FirebaseAuth.instance.currentUser!;
  final storage = StorageServices();
  final userDB = UserServices();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isLoading = false;
  File? image;
  String? imageURL;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user != null) {
      nameController.text = widget.user!.username;
      descriptionController.text = widget.user!.description;
      imageURL = widget.user!.avatar;
    }
  }
  void handleEdit(BuildContext context, String name, String description) async{
    try {
      imageURL = await storage.uploadImage(image!);
      UserModel user = UserModel(
        userId: widget.user!.userId,
        avatar: imageURL!,
        username: name,
        description: description,
        email: widget.user!.email,
      );
      currUser.updateProfile(displayName: name, photoURL: imageURL);
      userDB.updateUser(user);
      Message.showMessage(context, "Update successful", Commoncolor.green);
      pop(context);
    } catch (e) {
      Message.showMessage(context, "Update failed", Commoncolor.red);
      print("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Commoncolor.black,
      appBar: AppBar(
        backgroundColor: Commoncolor.black,
        foregroundColor: Commoncolor.white,
        leading: Padding(
          padding: EdgeInsets.all(12),
          child: IconButton(
            onPressed: () => pop(context), 
            icon: Icon(Icons.arrow_back, size: 20)
          ),
        ),
        centerTitle: true,
        title: Text("Update profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: image != null ? GestureDetector(
                onTap: () async{
                  final imagePicked = await showImagePickerModal(context);
                  if (imagePicked != null){
                    setState(() {
                      image = imagePicked;
                    });
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(image!,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ) : GestureDetector(
                onTap: () async{
                  final imagePicked = await showImagePickerModal(context);
                  if (imagePicked != null){
                    setState(() {
                      image = imagePicked;
                    });
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(imageURL!,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text("Full name",
              style: TextStyle(
                color: Commoncolor.white,
                fontSize: 16,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Commoncolor.white),
              decoration: InputDecoration(
                prefixIcon: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  child: Icon(Icons.person,
                    size: 20,
                    color: Commoncolor.grey,
                  ),
                ),
                hintText: "Your name",
                hintStyle: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(color: Commoncolor.white)
                )
              ),
            ),
            SizedBox(height: 20),
            Text("Description",
              style: TextStyle(
                color: Commoncolor.white,
                fontSize: 16,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              minLines: 3,
              maxLines: 3,
              style: TextStyle(color: Commoncolor.white),
              decoration: InputDecoration(
                prefixIcon: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  child: Icon(Icons.description,
                    size: 20,
                    color: Commoncolor.grey,
                  ),
                ),
                hintText: "Your description",
                hintStyle: TextStyle(
                  color: Commoncolor.white,
                  fontSize: 14
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(color: Commoncolor.white)
                )
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email:",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800
                  ),
                ),
                Text(widget.user!.email,
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
                    backgroundColor: Commoncolor.blue,
                    foregroundColor: Commoncolor.white
                  ),
                  onPressed: () async{
                    var name = nameController.text;
                    var description = descriptionController.text;
                    setState(() {
                      isLoading = true;
                    });
                    if (name.isEmpty) {
                      Message.showMessage(context, "Name is required", Commoncolor.red);
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      handleEdit(context, name, description);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }, 
                  child: isLoading 
                  ? Center(child: CircularProgressIndicator())
                  : Text("Update",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}