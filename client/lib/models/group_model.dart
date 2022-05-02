class GroupModel {
  final String? id;
  final String name;
  final String? description;
  final String? image;

  GroupModel({this.id, required this.name, this.description, this.image});

  factory GroupModel.fromJSON(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
