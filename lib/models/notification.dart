class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String? androidImageUrl;
  final String? iosImageUrl;
  final String? token;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;

  NotificationModel({
    required this.id, 
    required this.title, 
    required this.body,
    this.androidImageUrl,
    this.iosImageUrl, 
    this.token, 
    this.data, 
    required this.isRead, 
    required this.createdAt, 
    this.readAt
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "androidImageUrl": androidImageUrl,
    "iosImageUrl": iosImageUrl,
    "token": token,
    "data": data,
    "isRead": isRead,
    "createdAt": createdAt.toIso8601String(),
    "readAt": readAt?.toIso8601String()
  };

  factory NotificationModel.fromJson(Map<String, dynamic> data){
    return NotificationModel(
      id: data['id'] ?? '', 
      title: data['title'] ?? '', 
      body: data['body'] ?? '',
      androidImageUrl: data['androidImageUrl'], 
      iosImageUrl: data['iosImageUrl'], 
      token: data['token'], 
      data: data['data'] ?? {}, 
      isRead: data['isRead'] ?? false, 
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toIso8601String()), 
      readAt: data['readAt'] != null ? DateTime.parse(data['readAt']) : null
    );
  }
}