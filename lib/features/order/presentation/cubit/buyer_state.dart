class BuyerState {}

class BuyerInitial extends BuyerState{}

class BuyerLoading extends BuyerState{}

class BuyerLoaded extends BuyerState{}

class BuyerFailure extends BuyerState{
  final String message;
    BuyerFailure(this.message);  
}