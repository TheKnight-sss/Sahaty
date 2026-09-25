import 'package:sihati/features/order/models/person_model.dart';

class BuyerModel extends PersonModel {
  final String location;

  BuyerModel({
    super.id,
    required super.name,
    required this.location,
    required super.phone,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) {
    return BuyerModel(
      id: json['id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'location': location, 'phone': phone};
  }
}
