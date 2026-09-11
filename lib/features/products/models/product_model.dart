
class ProductModel{
   final String? id;
   final String? name;
   final double? price;
   final double? maxquan;
   final String? selled;
   final String? unit;
   final String? color;

    ProductModel({this.id, this.name, this.price, this.selled, this.color, this.unit, this.maxquan});

    factory ProductModel.fromJson(Map<String, dynamic> json){
        return ProductModel(
            id: json['id'],
            name: json['name'],
            price: json['price'],
            maxquan: json['maxquan'],
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
            'maxquan': maxquan,
            'color':color,
            'selled': selled,
            'unit': unit,
            "remaining": (maxquan != null && selled != null) ? (maxquan! - double.parse(selled!)) : null
        };
    }
}