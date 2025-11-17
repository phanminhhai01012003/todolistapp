class TodoModel{
  final String todoId;
  final String userId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  TodoModel({
    required this.todoId,
    required this.userId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status
  });
  Map<String, dynamic> toJson() => {
    "todoId": todoId,
    "userId": userId,
    "title": title,
    "description": description,
    "startDate": startDate,
    "endDate": endDate,
    "status": status
  };
  factory TodoModel.fromJson(Map<String, dynamic> data){
    return TodoModel(
      todoId: data['todoId'] ?? '', 
      userId: data['userId'] ?? '',
      title: data['title'] ?? '', 
      description: data['description'] ?? '', 
      startDate: data['startDate'].toDate() ?? DateTime.now(), 
      endDate: data['endDate'].toDate() ?? DateTime.now(),
      status: data['status'] ?? ''
    );
  }
  Map<String, dynamic> updateJson() => {
    "title": title,
    "description": description,
    "endDate": endDate
  };
}