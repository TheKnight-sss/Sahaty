class ProductModel{
   final String? id;
   final String? name;
   final double? price;
   final double? quantity;
   final String? selled;

    ProductModel({this.id, this.name, this.price, this.quantity, this.selled});

    factory ProductModel.fromJson(Map<String, dynamic> json){
        return ProductModel(
            id: json['id'],
            name: json['name'],
            price: json['price'],
            quantity: json['quantity'],
            selled: json['selled']
        );
    }

    Map<String, dynamic> toJson(){
        return {
            'id': id,
            'name': name,
            'price': price,
            'quantity': quantity,
            'selled': selled,
            "remaining": (quantity != null && selled != null) ? (quantity! - double.parse(selled!)) : null
        };
    }
}