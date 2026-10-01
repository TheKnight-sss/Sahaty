
class ProductModel{
   final String? id;
   final String? name;
   final double? price;
   final double? maxquan;
   final String? unit;
   final String? color;

    ProductModel({this.id, this.name, this.price, this.color, this.unit, this.maxquan,});

    factory ProductModel.fromJson(Map<String, dynamic> json){
        return ProductModel(
            id: json['id'],
            name: json['name'],
            price: json['price'],
            maxquan: json['maxquan'],
            color: json['color'],
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
            'unit': unit,
        };
    }
}