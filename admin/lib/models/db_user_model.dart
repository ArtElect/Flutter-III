class DbUserModel {
  final String? id;
  final String? pseudo;
  final String? firstname;
  final String? lastname;
  final String? image;
  final String? role;
  final String? userId;

  DbUserModel({this.id, this.pseudo, this.firstname, this.lastname, this.image, this.role, this.userId});

  factory DbUserModel.fromJson(Map<String, dynamic> json) {
    return DbUserModel(
      id: json['id'],
      pseudo: json['pseudo'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      image: json['image'],
      role: json['role'],
      userId: json['userId'],
    );
  }
}