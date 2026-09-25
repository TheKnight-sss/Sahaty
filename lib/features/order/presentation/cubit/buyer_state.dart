class PersonState {}

class PersonInitial extends PersonState{}

class PersonLoading extends PersonState{}

class PersonLoaded extends PersonState{}

class PersonFailure extends PersonState{
  final String message;
    PersonFailure(this.message);  
}