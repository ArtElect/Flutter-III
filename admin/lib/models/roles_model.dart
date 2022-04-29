import 'package:admin/models/db_user_model.dart';
import 'package:admin/models/groups_model.dart';
import 'package:admin/models/rights_model.dart';

class RolesModel {
  GroupsModel? group;
  List<RightsModel>? rights;
  DbUserModel? account;
  String? id;
  String? name;

  RolesModel({this.group, this.rights, this.account, this.id, this.name});

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      group: GroupsModel.fromJson(json['group']),
      rights: List<RightsModel>.from(json['rights'].map((x) => RightsModel.fromJson(x))),
      account: DbUserModel.fromJson(json['account']),
      id: json['id'],
      name: json['name'],
    );
  }
}