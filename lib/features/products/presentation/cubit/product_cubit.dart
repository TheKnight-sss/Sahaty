import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/products/models/product_model.dart';
import 'package:sihati/features/products/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  ProductModel? productmodel;
  List<ProductModel> products = [];
}