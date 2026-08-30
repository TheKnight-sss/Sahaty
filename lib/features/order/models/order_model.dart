import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sihati/features/order/models/order_item_model.dart';
import 'package:sihati/features/products/models/product_model.dart';

enum OrderStatus { pending, onDelivery, delivered }

class OrderModel {
  final String? buyer;
  final String? location;
  final double? cost;
  final String? rep;
  final List<OrderItemModel>? orderlist;
  final Timestamp? createdAt;
  final OrderStatus status;

  OrderModel({
    this.buyer,
    this.location,
    this.cost,
    this.rep,
    this.orderlist,
    this.createdAt,
    this.status = OrderStatus.pending,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      buyer: json['buyer'],
      location: json['location'],
      cost: (json['cost'] as num?)?.toDouble(),
      rep: json['rep'],
      orderlist: (json['orderlist'] as List?)
          ?.map((item) => OrderItemModel.fromjson(item))
          .toList(),
      createdAt: json['createdAt'],
      status: OrderStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'buyer': buyer,
      'location': location,
      'cost': cost,
      'rep': rep,
      'orderlist': orderlist?.map((product) => product.toJson()).toList(),
      'createdAt': createdAt,
      'status': status.name,
    };
  }
}
