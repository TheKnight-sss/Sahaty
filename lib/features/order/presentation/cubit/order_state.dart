class OrderState {}

  class OrderLoading extends OrderState{}

  class OrderSuccess extends OrderState{}

  class OrderFailure extends OrderState{
    final String message;
    OrderFailure(this.message);
  }

  class OrderItemsUpdated extends OrderState {}
  
