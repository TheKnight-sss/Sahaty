import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/order/models/order_model.dart';
import 'package:sihati/features/order/presentation/cubit/order_state.dart';
import 'package:sihati/features/products/models/product_model.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderLoading());

  List<OrderModel> orderitems = [];
  OrderModel? orderModel;
  final buyercontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final costcontroller = TextEditingController();
  final repcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> addOrder() async {
    if (!formkey.currentState!.validate()) {
      return;
    }

    try {
      final buyername = buyercontroller.text;

      final existingOrder = await FirebaseFirestore.instance
          .collection("Orders")
          .where("buyer", isEqualTo: buyername)
          .where("status",isEqualTo: OrderStatus.pending.name)
          .get();

          if (existingOrder.docs.isNotEmpty) {
      // Existing pending order
      final doc = existingOrder.docs.first;

      print("Pending order already exists: ${doc.id}");

      // Do something with this order
      return;
    }

      emit(OrderLoading());
      orderModel = OrderModel(
        buyer: buyername,
        location: locationcontroller.text,
        cost: double.tryParse(costcontroller.text),
        rep: repcontroller.text,
        orderlist: orderitems,
        status: OrderStatus.pending,
      );

      orderitems.add(
        OrderModel(
          buyer: buyername,
          location: locationcontroller.text
        )
      );

      final doc = await FirebaseFirestore.instance
        .collection("Orders")
        .add({
          ...orderModel!.toJson(),
          'createdAt': FieldValue.serverTimestamp(),
        });
    } catch (e) {}
  }
}
