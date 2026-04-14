import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolistapp/models/notification.dart';

class NotificationData {
  final notificationCollection = FirebaseFirestore.instance.collection("notification");
  Future<void> saveNotification(NotificationModel model) async{
    try {
      await notificationCollection.doc(model.id).set(model.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<void> updateReadNotifications(String id) async {
    try {
      await notificationCollection.doc(id).update({
        'isRead': true,
        'readAt': DateTime.now()
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Stream<List<NotificationModel>> getNotification(String token) {
    try {
      return notificationCollection
        .where('token', isEqualTo: token)
        .snapshots()
        .map((value) => value.docs.map((e) => NotificationModel.fromJson(e.data())).toList());
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}