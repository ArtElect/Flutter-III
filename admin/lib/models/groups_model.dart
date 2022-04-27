class GroupsModel {
  final String? id;
  final String? description;
  final String? title;

  GroupsModel({this.id, this.description, this.title});

  factory GroupsModel.fromJson(Map<String, dynamic> json) {
    return GroupsModel(
      id: json['id'],
      description: json['description'],
      title: json['title'],
    );
  }
}