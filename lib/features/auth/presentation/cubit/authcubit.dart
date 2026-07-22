import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/auth/models/admin_model.dart';
import 'package:sihati/features/auth/models/coRep_model.dart';
import 'package:sihati/features/auth/models/user_type_enum.dart';
import 'package:sihati/features/auth/presentation/cubit/authstate.dart';

class AuthCubit extends Cubit<Authstate> {
  AuthCubit() : super(AuthInitial());

  AdminModel? adminModel;
  CoRepModel? coRepModel;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register({required UserTypeEnum type}) async {
    emit(AuthLoading());

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      User? user = credential.user;
      //! Use Photo URL as Role
      await user?.updatePhotoURL(
        type == UserTypeEnum.admin ? 'admin' : 'coRep',
      );
      await user?.updateDisplayName(nameController.text);

      if (type == UserTypeEnum.admin) {
        var admin = AdminModel(
          id: user?.uid,
          name: nameController.text,
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
        );
        await FirebaseFirestore.instance
            .collection('admins')
            .doc(user?.uid)
            .set(admin.toJson());
      } else {
        var coRep = CoRepModel(
          id: user?.uid,
          name: nameController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
        );
        await FirebaseFirestore.instance
            .collection('coRep')
            .doc(user?.uid)
            .set(coRep.toJson());
      }
      emit(AuthSuccess(role: type, adminModel: adminModel, coRepModel: coRepModel));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailure("كلمة المرور ضعيفة جدا"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailure("البريد الإلكتروني مستخدم بالفعل"));
      } else {
        emit(AuthFailure("فشل في المصادقة, يرجى المحاولة مرة أخرى"));
      }
    } catch (e) {
      emit(AuthFailure("فشل في المصادقة"));
    }
  }

  Future<void> login() async {
    debugPrint("emit AuthLoading");
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final role = credential.user?.photoURL == 'admin'
          ? UserTypeEnum.admin
          : UserTypeEnum.coRep;
      User? user = credential.user;
      if (role == UserTypeEnum.admin) {
        var adminDoc = await FirebaseFirestore.instance
            .collection('admins')
            .doc(user?.uid)
            .get();
        adminModel = AdminModel.fromJson(adminDoc.data()!);
      } else {
        var coRepDoc = await FirebaseFirestore.instance
            .collection('coRep')
            .doc(user?.uid)
            .get();
        coRepModel = CoRepModel.fromJson(coRepDoc.data()!);
      }
      emit(AuthSuccess(role: role, adminModel: adminModel, coRepModel: coRepModel));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailure("المستخدم غير موجود"));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure("كلمة المرور خاطئة"));
      } else {
        emit(AuthFailure("فشل في المصادقة, يرجى المحاولة مرة أخرى"));
      }
    } catch (e) {
      emit(AuthFailure("فشل في المصادقة"));
    }
  }
}
