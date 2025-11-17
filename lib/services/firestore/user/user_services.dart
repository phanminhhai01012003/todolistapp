import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolistapp/models/user.dart';
import 'package:todolistapp/services/firestore/user/user_repo.dart';

class UserServices extends UserRepo{
  final userCollection = FirebaseFirestore.instance.collection("user");
  final user = FirebaseAuth.instance.currentUser;
  @override
  Future<void> addUser(UserModel user) async{
    // TODO: implement addUser
    try {
      return await userCollection.doc(user.userId).set(user.toJson());
    } catch (e) {
      print("Error: $e");
      rethrow;
    }    
  }

  @override
  Future<void> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) async{
    // TODO: implement updateUser
    try {
      return await userCollection.doc(user.userId).update(user.updateJson());
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Stream<List<UserModel>> get getUser {
    try {
      return userCollection
        .where("userId", isEqualTo: user!.uid)
        .snapshots()
        .map((event) => event.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}