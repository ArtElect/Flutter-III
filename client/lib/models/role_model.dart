import 'package:client/models/group_model.dart';
import 'package:client/models/right_model.dart';
import 'package:client/models/user_model.dart';

class RoleModel {
  final String id;
  final GroupModel group;
  final List<RightModel> rights;
  final UserModel user;

  RoleModel({required this.id, required this.group, required this.rights, required this.user});

  factory RoleModel.fromJSON(Map<String, dynamic> json) {
    List<RightModel> listOfRight = [];

    for (var right in json['rights']) {
      listOfRight.add(RightModel.fromJSON(right));
    }

    return RoleModel(
      id: json['id'],
      group: GroupModel.fromJSON(json['group']),
      rights: listOfRight,
      user: UserModel.fromJSON(json['account'])
    );
  }
}