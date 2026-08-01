import 'package:sihati/features/products/models/product_model.dart';

class ProductState{}

class ProductInitial extends ProductState{}

class ProductSuccess extends ProductState{
  final List<ProductModel> products;

  ProductSuccess(this.products);
}

class ProductFailure extends ProductState{
  final String error;

  ProductFailure(this.error);
}