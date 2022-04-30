class UserModel {
  String? id;
  final String userId;
  final String role;
  String? image = "";
  final String firstName;
  final String lastName;
  final String pseudo;

  UserModel({
    this.id,
    required this.userId,
    required this.role,
    this.image,
    required this.firstName,
    required this.lastName,
    required this.pseudo,
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      userId: json["userId"],
      role: json["role"],
      image: json["image"],
      firstName: json["firstname"],
      lastName: json["lastname"],
      pseudo: json["pseudo"],
    );
  }
}
