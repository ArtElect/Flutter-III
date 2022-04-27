import 'package:admin/models/db_user_model.dart';
import 'package:admin/models/groups_model.dart';

class ProjectModel {
  GroupsModel? group;
  DbUserModel? account;
  List<SingleProjectModel>? projects;
  String? id;
  
  ProjectModel({this.group, this.account, this.projects, this.id});

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      group: GroupsModel.fromJson(json['group']),
      account: DbUserModel.fromJson(json['account']),
      projects: List<SingleProjectModel>.from(json["projects"].map((x) => SingleProjectModel.fromJson(x))),
      id: json['id'],
    );
  }
}

class SingleProjectModel {
  String? projectId;
  String? image;
  String? description;
  String? title;
  String? groupId;
  
  SingleProjectModel({this.projectId, this.image, this.description, this.title, this.groupId});

  factory SingleProjectModel.fromJson(Map<String, dynamic> json) {
    return SingleProjectModel(
      projectId: json['id'],
      image: json['image'],
      description: json['description'],
      title: json['title'],
      groupId: json['group']['_path']['segments'][1],
    );
  }
}