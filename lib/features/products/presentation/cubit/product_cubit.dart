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
  final capacityController = TextEditingController();
  final priceController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> addProduct({required String unit, required String color}) async {
    if (!formkey.currentState!.validate()) {
      return;
    }

    try {
      final productName = productnameController.text.trim();

      // Check if product already exists
      final existingProduct = await FirebaseFirestore.instance
          .collection("Products")
          .where("name", isEqualTo: productName)
          .limit(1)
          .get();

      if (existingProduct.docs.isNotEmpty) {
        emit(ProductFailure("Product already exists"));
        return;
      }

      productmodel = ProductModel(
        id: "",
        name: productName,
        price: double.tryParse(priceController.text),
        capacity: double.tryParse(capacityController.text),
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
          capacity: productmodel!.capacity,
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

  Future<void> addToStock({
    required String productId,
    required double quantity,
  }) async {
    try {

      await FirebaseFirestore.instance.collection('Products').doc(productId).update({
        'quantity': FieldValue.increment(quantity),
      });
      await getProduct();
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  void resetProduct() {
    productnameController.clear();
    capacityController.clear();
    priceController.clear();
  }
}
