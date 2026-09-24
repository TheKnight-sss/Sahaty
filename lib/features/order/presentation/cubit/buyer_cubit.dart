import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/order/models/buyer_model.dart';
import 'package:sihati/features/order/presentation/cubit/buyer_state.dart';

class BuyerCubit extends Cubit<BuyerState> {
  BuyerCubit() : super(BuyerInitial());

  final buyerNameController = TextEditingController();
  final locationController = TextEditingController();

  List<BuyerModel> buyersList = [];

  Future<void> addBuyers() async {
    try {
      emit(BuyerLoading());
      final buyername = buyerNameController.text;
      final existingbuyer = await FirebaseFirestore.instance
          .collection('Buyers')
          .where('buyer', isEqualTo: buyername)
          .get();

          if(existingbuyer.docs.isNotEmpty){
            emit(BuyerFailure("This Buyer Is Already Exist"));
          }
      final buyer = BuyerModel(
        name: buyerNameController.text,
        location: locationController.text,
      );
      final doc = await FirebaseFirestore.instance
          .collection('Buyers')
          .add(buyer.toJson());

      final newbuyer = BuyerModel(
        id: doc.id,
        name: buyer.name,
        location: buyer.location,
      );

      buyersList.add(newbuyer);
    } catch (e) {
      emit(BuyerFailure(e.toString()));
    }
  }

  Future<void> getBuyers() async {
    try {
      emit(BuyerLoading());
      final snapshot = await FirebaseFirestore.instance
          .collection('Buyers')
          .get();

      buyersList = snapshot.docs.map((doc) {
        return BuyerModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
      emit(BuyerLoaded());
    } catch (e) {
      emit(BuyerFailure(e.toString()));
    }
  }
}
