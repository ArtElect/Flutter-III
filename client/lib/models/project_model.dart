class ProjectModel {
  String? id;
  String? title;
  String? description;
  String? image;

  ProjectModel({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  factory ProjectModel.fromJSON(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
