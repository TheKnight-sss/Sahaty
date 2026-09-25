class PersonModel {
  final String? id;
  final String name;
  final String phone;

  PersonModel({this.id, required this.name, required this.phone});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      id: json['id'],
    );
  }
}
