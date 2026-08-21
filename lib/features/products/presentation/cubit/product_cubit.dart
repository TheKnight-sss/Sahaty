import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/products/models/product_model.dart';
import 'package:sihati/features/products/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  ProductModel? productmodel;
  List<ProductModel> products = [];
  final productnameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> addProduct({required String unit, required String color}) async {
    if (!(formkey.currentState?.validate() ?? false)) return;

    try {
      productmodel = ProductModel(
        id: "",
        name: productnameController.text,
        price: double.tryParse(priceController.text),
        quantity: double.tryParse(quantityController.text),
        unit: unit,
        color: color,
      );

      final doc = await FirebaseFirestore.instance
          .collection("Products")
          .add(productmodel!.toJson());

      products.add(
        ProductModel(
          id: doc.id,
          name: productmodel!.name,
          price: productmodel!.price,
          quantity: productmodel!.quantity,
          unit: productmodel!.unit,
          color: productmodel!.color,
        ),
      );
      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  Future<void> getProduct() async {
    try {
      emit(ProductInitial());
      final snapshot = await FirebaseFirestore.instance
          .collection("Products")
          .get();

      products = snapshot.docs.map((doc) {
        return ProductModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
