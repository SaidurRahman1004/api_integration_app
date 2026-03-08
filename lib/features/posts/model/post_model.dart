class PostModel {
  final int id;
  final String title;
  final String body;
  final int userId;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  // Convert JSON to dart obj to get data from api
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }
// Convert dart obj to JSON to set data in api
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body, 'userId': userId};
  }
}
