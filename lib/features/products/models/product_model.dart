
class ProductModel{
   final String? id;
   final String? name;
   final double? price;
   final double? quantity;
   final String? selled;
   final String? unit;
   final String? color;

    ProductModel({this.id, this.name, this.price, this.quantity, this.selled, this.color, this.unit});

    factory ProductModel.fromJson(Map<String, dynamic> json){
        return ProductModel(
            id: json['id'],
            name: json['name'],
            price: json['price'],
            quantity: json['quantity'],
            color: json['color'],
            selled: json['selled'],
            unit: json['unit']
        );
    }

    Map<String, dynamic> toJson(){
        return {
            'id': id,
            'name': name,
            'price': price,
            'quantity': quantity,
            'color':color,
            'selled': selled,
            'unit': unit,
            "remaining": (quantity != null && selled != null) ? (quantity! - double.parse(selled!)) : null
        };
    }
}