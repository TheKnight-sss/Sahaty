import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/order/models/order_item_model.dart';
import 'package:sihati/features/order/models/order_model.dart';
import 'package:sihati/features/order/presentation/cubit/order_state.dart';
import 'package:sihati/features/products/models/product_model.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  List<OrderItemModel> selectedOrderItems = [];
  List<OrderModel> orderList = [];
  OrderModel? orderModel;
  final buyercontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final repcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void addProductToOrder(ProductModel product) {
    final index = selectedOrderItems.indexWhere(
      (item) => item.name == product.name,
    );

    if (index == -1) {
      selectedOrderItems.add(
        OrderItemModel(
          name: product.name,
          unit: product.unit,
          price: product.price,
          quantity: null,
          color: product.color,
        ),
      );
    }

    emit(OrderItemsUpdated());
  }

  void updateProductQuantity(int index, double quantity) {
    final item = selectedOrderItems[index];

    selectedOrderItems[index] = OrderItemModel(
      name: item.name,
      unit: item.unit,
      price: item.price,
      quantity: quantity,
      color: item.color,
    );

    emit(OrderItemsUpdated());
  }

  double updateOrderTotalPrice() {
    double totalPrice = 0;

    for (final item in selectedOrderItems) {
      totalPrice += (item.price ?? 0) * (item.quantity ?? 0);
    }

    return totalPrice;
  }

  void removeProductFromOrder(int index) {
    selectedOrderItems.removeAt(index);

    emit(OrderItemsUpdated());
  }

  Future<void> addOrder() async {
    if (!formkey.currentState!.validate()) {
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

      orderModel = OrderModel(
        id: "",
        buyer: buyername,
        location: locationcontroller.text,
        cost: updateOrderTotalPrice(),
        rep: repcontroller.text,
        orderlist: selectedOrderItems,
        status: OrderStatus.pending,
      );

      final doc = await FirebaseFirestore.instance.collection("Orders").add({
        ...orderModel!.toJson(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      orderList.add(
        OrderModel(
          id: doc.id,
          buyer: orderModel!.buyer,
          location: orderModel!.location,
          cost: orderModel!.cost,
          rep: orderModel!.rep,
          orderlist: orderModel!.orderlist,
          status: orderModel!.status,
        ),
      );

      emit(OrderSuccess(orders: orderList));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> getOrder() async {
    try {
      emit(OrderLoading());
      final snapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .get();

      orderList = snapshot.docs.map((doc) {
        return OrderModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
      emit(OrderSuccess(orders: orderList));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  void resetOrder() {
  selectedOrderItems.clear();
  buyercontroller.clear();
  locationcontroller.clear();
  repcontroller.clear();
}
}
