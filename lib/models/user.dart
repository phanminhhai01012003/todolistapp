class UserModel{
  final String userId;
  final String avatar;
  final String username;
  final String description;
  final String email;
  final String? token;
  UserModel({
    required this.userId,
    required this.avatar,
    required this.description,
    required this.username,
    required this.email,
    this.token
  });
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "avatar": avatar,
    "username": username,
    "description": description,
    "email": email,
    "token": token
  };
  factory UserModel.fromJson(Map<String, dynamic> data){
    return UserModel(
      userId: data['userId'] ?? '', 
      avatar: data['avatar'] ?? '',
      username: data['username'] ?? '', 
      description: data['description'] ?? '',
      email: data['email'] ?? '', 
      token: data['token'] ?? '',
    );
  }
  Map<String, dynamic> updateJson() => {
    "avatar": avatar,
    "username": username,
    "description": description
  };
}