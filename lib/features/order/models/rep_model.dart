import 'package:sihati/features/order/models/person_model.dart';

class RepModel extends PersonModel {
  RepModel({super.id, required super.name, required super.phone});

  factory RepModel.fromJson(Map<String, dynamic> json) {
    return RepModel(id: json['id'], name: json['name'], phone: json['phone']);
  }

  Map<String,dynamic>toJson(){
    return{
      'name':name,
      'phone':phone
    };
  }
}
