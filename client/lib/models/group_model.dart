class GroupModel {
  final String name;
  final String? description;
  final String? image;

  GroupModel({required this.name, this.description, this.image});

  factory GroupModel.fromJSON(Map<String, dynamic> json) {
    return GroupModel(
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
