class GroupModel {
  final String? name;
  final String? description;

  GroupModel({this.name, this.description});

  factory GroupModel.fromJSON(Map<String, dynamic> json) {
    return GroupModel(name: json['title'], description: json['description']);
  }
}
