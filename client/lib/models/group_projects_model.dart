import 'package:client/models/group_model.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/project_model.dart';

class GroupProjectsModel {
  final String id;
  final GroupModel group;
  // final UserModel user;
  final List<ProjectModel> projects;

  GroupProjectsModel({
    required this.id,
    required this.group,
    // required this.user,
    required this.projects,
  });

  factory GroupProjectsModel.fromJSON(Map<String, dynamic> json) {
    List<ProjectModel> listOfProject = [];

    for (var project in json['projects']) {
      listOfProject.add(ProjectModel.fromJSON(project));
    }

    return GroupProjectsModel(
      id: json['id'],
      group: GroupModel.fromJSON(json['group']),
      // user: UserModel.fromJSON(json['account']),
      projects: listOfProject,
    );
  }
}
