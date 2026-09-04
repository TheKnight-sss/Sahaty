import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/order/models/order_item_model.dart';
import 'package:sihati/features/order/models/order_model.dart';
import 'package:sihati/features/order/presentation/cubit/order_state.dart';
import 'package:sihati/features/products/models/product_model.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderLoading());

  List<OrderItemModel> selectedOrderItems = [];
  OrderModel? orderModel;
  final buyercontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final costcontroller = TextEditingController();
  final repcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void addProductToOrder(ProductModel product, double quantity) {
    final orderItem = OrderItemModel(
      name: product.name,
      unit: product.unit,
      price: product.price,
      quantity: quantity,
    );
    selectedOrderItems.add(orderItem);

    emit(OrderItemsUpdated());
  }

  void removeProductFromOrder(int index) {
    selectedOrderItems.removeAt(index);

    emit(OrderItemsUpdated());
  }

  Future<void> addOrder(BuildContext context, String buyer, String location, String rep) async {
    if (!formkey.currentState!.validate()) {
      return;
    }

    if (selectedOrderItems.isEmpty) {
      emit(OrderFailure("Please add at least one product"));
      return;
    }

    try {
      emit(OrderLoading());
      final buyername = buyercontroller.text;

      final existingOrder = await FirebaseFirestore.instance
          .collection("Orders")
          .where("buyer", isEqualTo: buyername)
          .where("status", isEqualTo: OrderStatus.pending.name)
          .get();

      if (existingOrder.docs.isNotEmpty) {
        // Existing pending order
        emit(OrderFailure("This buyer already has a pending order"));

        // Do something with this order
        return;
      }

      emit(OrderLoading());
      orderModel = OrderModel(
        buyer: buyername,
        location: locationcontroller.text,
        cost: double.tryParse(costcontroller.text),
        rep: repcontroller.text,
        orderlist: selectedOrderItems,
        status: OrderStatus.pending,
      );


      await FirebaseFirestore.instance
          .collection("Orders")
          .add({
        ...orderModel!.toJson(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      emit(OrderSuccess());
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
