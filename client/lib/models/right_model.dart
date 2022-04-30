class RightModel {
  final String name;

  RightModel({required this.name});

  factory RightModel.fromJSON(Map<String, dynamic> json) {
    return RightModel(
      name: json['action'],
    );
  }
}
