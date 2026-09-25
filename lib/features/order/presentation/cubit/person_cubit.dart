import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/order/models/buyer_model.dart';
import 'package:sihati/features/order/models/rep_model.dart';
import 'package:sihati/features/order/presentation/cubit/buyer_state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonInitial());

  final buyerNameController = TextEditingController();
  final repNameController = TextEditingController();
  final locationController = TextEditingController();
  final buyerphoneController = TextEditingController();
  final repphoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  BuyerModel? selectedbuyer;
  RepModel? selectedrep;

  List<BuyerModel> buyersList = [];
  List<RepModel> repsList = [];

  //!Buyers///////////////////////////////////

  Future<void> addBuyers() async {
    try {
      emit(PersonLoading());
      final buyername = buyerNameController.text;
      final existingbuyer = await FirebaseFirestore.instance
          .collection('Buyers')
          .where('buyer', isEqualTo: buyername)
          .get();

      if (existingbuyer.docs.isNotEmpty) {
        emit(PersonFailure("This Buyer Is Already Exist"));
      }
      final buyer = BuyerModel(
        name: buyerNameController.text,
        location: locationController.text,
        phone: buyerphoneController.text,
      );
      final doc = await FirebaseFirestore.instance
          .collection('Buyers')
          .add(buyer.toJson());

      final newbuyer = BuyerModel(
        id: doc.id,
        name: buyer.name,
        location: buyer.location,
        phone: buyer.phone,
      );

      buyersList.add(newbuyer);
    } catch (e) {
      emit(PersonFailure(e.toString()));
    }
  }

  Future<void> getBuyers() async {
    try {
      emit(PersonLoading());
      final snapshot = await FirebaseFirestore.instance
          .collection('Buyers')
          .get();

      buyersList = snapshot.docs.map((doc) {
        return BuyerModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
      emit(PersonLoaded());
    } catch (e) {
      emit(PersonFailure(e.toString()));
    }
  }
  //!Reps/////////////////////////////////////////////////////////////////

  Future<void> addReps() async {
    try {
      emit(PersonLoading());
      final repname = repNameController.text;
      final existingbuyer = await FirebaseFirestore.instance
          .collection('Reps')
          .where('rep', isEqualTo: repname)
          .get();

      if (existingbuyer.docs.isNotEmpty) {
        emit(PersonFailure("This Rep Is Already Exist"));
      }
      final rep = RepModel(
        name: repNameController.text,
        phone: repphoneController.text,
      );
      final doc = await FirebaseFirestore.instance
          .collection('Reps')
          .add(rep.toJson());

      final newRep = RepModel(id: doc.id, name: rep.name, phone: rep.phone);

      repsList.add(newRep);
    } catch (e) {
      emit(PersonFailure(e.toString()));
    }
  }

  Future<void> getReps() async {
    try {
      emit(PersonLoading());
      final snapshot = await FirebaseFirestore.instance
          .collection('Reps')
          .get();

      repsList = snapshot.docs.map((doc) {
        return RepModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
      emit(PersonLoaded());
    } catch (e) {
      emit(PersonFailure(e.toString()));
    }
  }

  void resetbuyer() {
    buyerNameController.clear();
    buyerphoneController.clear();
    locationController.clear();
    repNameController.clear();
    repphoneController.clear();
  }
}
