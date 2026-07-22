class AdminModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? balance;

  AdminModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.balance,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json){
    return AdminModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      balance: json['balance'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'balance': balance,
    };
  }

  Map<String, dynamic> updateData(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (balance != null) {
      data['balance'] = balance;
    }
    return data;
  }

}