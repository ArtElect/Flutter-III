class ProjectModel {
  String? projectId;
  String? image;
  String? description;
  String? title;
  String? groupId;
  
  ProjectModel({this.projectId, this.image, this.description, this.title, this.groupId});

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['id'],
      image: json['image'],
      description: json['description'],
      title: json['title'],
      groupId: json['group']['_path']['segments'][1],
    );
  }
}