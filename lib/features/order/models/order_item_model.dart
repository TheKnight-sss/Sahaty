class OrderItemModel {

  final String? name;
  final String? unit;
  final double? quantity;
  final double? price;

  OrderItemModel({this.name, this.unit, this.quantity, this.price});

  factory OrderItemModel.fromjson(Map<String,dynamic>json){
    return OrderItemModel(
      name: json['name'],
      unit: json['unit'],
      quantity: json['quantity'],
      price: json['price']
    );
  }

  Map<String, dynamic>toJson(){
    return {
      'name' : name,
      'unit' : unit,
      'quantity': quantity,
      'price': price
    };
  }
}