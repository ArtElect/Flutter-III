import 'package:client/models/group_model.dart';
import 'package:client/models/right_model.dart';
import 'package:client/models/user_model.dart';

class RoleModel {
  final String id;
  final String name;
  final GroupModel group;
  final List<RightModel> rights;
  final List<UserModel> users;

  RoleModel({
    required this.id,
    required this.name,
    required this.group,
    required this.rights,
    required this.users,
  });

  factory RoleModel.fromJSON(Map<String, dynamic> json) {
    List<RightModel> listOfRight = [];
    List<UserModel> listOfUser = [];
    for (var right in json['rights']) {
      listOfRight.add(RightModel.fromJSON(right));
    }

    for (var user in json['accounts']) {
      listOfUser.add(UserModel.fromJSON(user));
    }

    return RoleModel(
        id: json['id'],
        name: json['name'],
        group: GroupModel.fromJSON(json['group']),
        rights: listOfRight,
        users: listOfUser,
    );
  }
}
