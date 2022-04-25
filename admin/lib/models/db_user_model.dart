class DbUserModel {
  final String? id;
  final String? image;
  final String? role;
  final String? userId;

  DbUserModel({this.id, this.image, this.role, this.userId});

  factory DbUserModel.fromJson(Map<String, dynamic> json) {
    return DbUserModel(
      id: json['id'],
      image: json['image'],
      role: json['role'],
      userId: json['userId'],
    );
  }
}