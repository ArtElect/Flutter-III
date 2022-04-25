import 'package:client/models/group_model.dart';
import 'package:client/models/right_model.dart';
import 'package:client/models/user_model.dart';

class RoleModel {
  final String id;
  final GroupModel groups;
  List<RightModel> rights = [];
  final UserModel users;

  RoleModel({required this.id, required this.groups, required this.rights, required this.users});

  factory RoleModel.fromJSON(Map<String, dynamic> json) {
    List<RightModel> listOfRight = [];

    for (var right in json['rights']) {
      listOfRight.add(RightModel.fromJSON(right));
    }

    return RoleModel(
      id: json['id'],
      groups: GroupModel.fromJSON(json['groups']),
      rights: listOfRight,
      users: UserModel.fromJSON(json['account'])
    );
  }
}