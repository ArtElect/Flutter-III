class UserModel {
  final String? userId;
  final String? role;
  final String? image;

  UserModel({required this.userId, required this.role, required this.image});

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      role: json["role"],
      image: json["image"]
    );
  }

}