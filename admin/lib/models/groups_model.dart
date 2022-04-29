import 'package:admin/models/project_model.dart';

class GroupsModel {
  final String? id;
  final String? image;
  final String? description;
  final String? name;
  final List<ProjectModel>? projects;

  GroupsModel({this.id, this.image, this.description, this.name, this.projects});

  factory GroupsModel.fromJson(Map<String, dynamic> json) {
    return GroupsModel(
      id: json['id'],
      image: json['image'],
      description: json['description'],
      name: json['name'],
      projects: List<ProjectModel>.from(json['projects'].map((x) => ProjectModel.fromJson(x))),
    );
  }
}