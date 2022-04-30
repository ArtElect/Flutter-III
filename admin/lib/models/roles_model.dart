import 'package:admin/models/rights_model.dart';

class RolesModel {
  RolesGroupModel? group;
  List<RightsModel>? rights;
  List<RolesAccountsModel>? account;
  String? id;
  String? name;

  RolesModel({this.group, this.rights, this.account, this.id, this.name});

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      group: RolesGroupModel.fromJson(json['group']),
      rights: List<RightsModel>.from(json['rights'].map((x) => RightsModel.fromJson(x))),
      account: List<RolesAccountsModel>.from(json['accounts'].map((x) => RolesAccountsModel.fromJson(x))),
      id: json['id'],
      name: json['name'],
    );
  }
}

class RolesGroupModel {
  final String? image;
  final String? description;
  final String? name;

  RolesGroupModel({this.image, this.description, this.name});

  factory RolesGroupModel.fromJson(Map<String, dynamic> json) {
    return RolesGroupModel(
      image: json['image'],
      description: json['description'],
      name: json['name'],
    );
  }
}

class RolesAccountsModel {
  final String? image;
  final String? firstname;
  final String? role;
  final String? userId;
  final String? lastname;
  final String? pseudo;

  RolesAccountsModel({this.image, this.firstname, this.role, this.userId, this.lastname, this.pseudo});

  factory RolesAccountsModel.fromJson(Map<String, dynamic> json) {
    return RolesAccountsModel(
      image: json['image'],
      firstname: json['firstname'],
      role: json['role'],
      userId: json['userId'],
      lastname: json['lastname'],
      pseudo: json['pseudo'],
    );
  }
}