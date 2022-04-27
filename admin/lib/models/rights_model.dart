class RightsModel {
  String? id;
  String? action;

  RightsModel({this.id, this.action});

  factory RightsModel.fromJson(Map<String, dynamic> json) {
    return RightsModel(
      id: json['id'],
      action: json['action'],
    );
  }
}