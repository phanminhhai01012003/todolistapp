class UserModel{
  final String userId;
  final String avatar;
  final String username;
  final String description;
  final String email;
  UserModel({
    required this.userId,
    required this.avatar,
    required this.description,
    required this.username,
    required this.email
  });
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "avatar": avatar,
    "username": username,
    "description": description,
    "email": email
  };
  factory UserModel.fromJson(Map<String, dynamic> data){
    return UserModel(
      userId: data['userId'] ?? '', 
      avatar: data['avatar'] ?? '',
      username: data['username'] ?? '', 
      description: data['description'] ?? '',
      email: data['email'] ?? '', 
    );
  }
  Map<String, dynamic> updateJson() => {
    "avatar": avatar,
    "username": username,
    "description": description
  };
}