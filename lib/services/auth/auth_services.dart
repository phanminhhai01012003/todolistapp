import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/services/auth/auth_repo.dart';
import 'package:todolistapp/widget/message.dart';

class AuthServices extends AuthRepo{
  final _auth = FirebaseAuth.instance;
  @override
  Future<void> changePassword(BuildContext context, {email, oldpassword, newPassword}) async{
    // TODO: implement changePassword
    var cred = EmailAuthProvider.credential(email: email, password: oldpassword);
    await _auth.currentUser!.reauthenticateWithCredential(cred).then((value){
      _auth.currentUser!.updatePassword(newPassword);
    }).catchError((e){
      Message.showMessage(context, "Change Password Failed!", Commoncolor.red);
    });
  }

  @override
  Future<User?> login(BuildContext context, String email, String password) async{
    // TODO: implement login
    try{
      UserCredential res = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = res.user;
      return user;
    }catch(e){
      Message.showMessage(context, "Login Failed!", Commoncolor.red);
      return null;
    }
  }

  @override
  Future<User?> register(BuildContext context, String avatar, String username, String email, String password) async{
    // TODO: implement register
    try{
      UserCredential res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = res.user;
      user?.updateProfile(displayName: username, photoURL: avatar);
      return user;
    }catch(e){
      Message.showMessage(context, "Register Failed!", Commoncolor.red);
      return null;
    }
  }

  @override
  Future<void> resetPassword(BuildContext context, String email) async{
    // TODO: implement resetPassword
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      Message.showMessage(context, "An error has been occurred!", Commoncolor.red);
    }
  }
  
  @override
  Future<void> logOut(BuildContext context) async{
    // TODO: implement logOut
    try{
      await _auth.signOut();
    }catch(e){
      Message.showMessage(context, "Logout failed!", Commoncolor.red);
    }
  }

}