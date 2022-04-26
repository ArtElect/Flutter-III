import 'package:admin/models/db_user_model.dart';
import 'package:admin/models/groups_model.dart';
import 'package:admin/models/rights_model.dart';

class RolesModel {
  GroupsModel? group;
  List<RightsModel>? rights;
  DbUserModel? account;
  String? id;

  RolesModel({this.group, this.rights, this.account, this.id});

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      group: json['group'],
      rights: json['rights'],
      account: json['account'],
      id: json['id'],
    );
  }
}