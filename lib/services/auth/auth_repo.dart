import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthRepo {
  Future<User?> login(BuildContext context, String email, String password);
  Future<User?> register(BuildContext context, String avatar, String username, String email, String password);
  Future<void> logOut(BuildContext context);
  Future<void> resetPassword(BuildContext context, String email);
  Future<void> changePassword(BuildContext context, {email, oldpassword, newPassword}); 
}