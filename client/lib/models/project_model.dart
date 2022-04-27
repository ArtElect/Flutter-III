class ProjectModel {
  final String? id;
  final String? title;
  final String? description;
  final String? image;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
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
