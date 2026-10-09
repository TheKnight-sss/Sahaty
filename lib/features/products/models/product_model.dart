class ProductModel {
  final String? id;
  final String? name;
  final double? price;
  final double? capacity;
  final int? quantity;
  final String? unit;
  final String? color;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.color,
    this.unit,
    this.capacity,
    this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      capacity: (json['capacity'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      color: json['color'] as String?,
      unit: json['unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'capacity': capacity,
      'quantity': quantity,
      'color': color,
      'unit': unit,
    };
  }
}
