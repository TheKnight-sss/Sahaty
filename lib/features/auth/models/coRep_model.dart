class CoRepModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? address;

  CoRepModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
  });

  factory CoRepModel.fromJson(Map<String, dynamic> json) {
    return CoRepModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}