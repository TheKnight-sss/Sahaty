import 'package:sihati/features/order/models/order_model.dart';

class OrderState {}
 
  class OrderInitial extends OrderState{}

  class OrderLoading extends OrderState{}

  class OrderSuccess extends OrderState{
    final List<OrderModel> orders;
    OrderSuccess({required this.orders});
  }

  class OrderFailure extends OrderState{
    final String message;
    OrderFailure(this.message);
  }

  class OrderItemsUpdated extends OrderState {}
  
