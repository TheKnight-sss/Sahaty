class BuyerModel {
  final String? id;
  final String name;
  final String location;

  BuyerModel({
    this.id,
    required this.name,
    required this.location,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) {
    return BuyerModel(
      id: json['id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
    };
  }
}