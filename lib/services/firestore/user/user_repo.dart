import 'package:todolistapp/models/user.dart';

abstract class UserRepo {
  Future<void> addUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String id);
}