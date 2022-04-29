class GroupsModel {
  final String? id;
  final String? description;
  final String? name;
  final String? image;

  GroupsModel({this.id, this.description, this.name, this.image});

  factory GroupsModel.fromJson(Map<String, dynamic> json) {
    return GroupsModel(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      image: json['image']
    );
  }
}