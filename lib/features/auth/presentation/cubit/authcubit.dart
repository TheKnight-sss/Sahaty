import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sihati/features/auth/models/admin_model.dart';
import 'package:sihati/features/auth/models/user_type_enum.dart';
import 'package:sihati/features/auth/presentation/cubit/authstate.dart';

class AuthCubit extends Cubit<Authstate> {
  AuthCubit() : super(AuthInitial());

  AdminModel? adminModel;

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
      await user!.updatePhotoURL(
        'admin',
      );
      await user.updateDisplayName(nameController.text);

      
        var admin = AdminModel(
          id: user.uid,
          name: nameController.text,
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
        );
        await FirebaseFirestore.instance
            .collection('admins')
            .doc(user.uid)
            .set(admin.toJson());
      
      emit(AuthSuccess(role: type, adminModel: adminModel));
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
      final role = credential.user!;
          
      
        var adminDoc = await FirebaseFirestore.instance
            .collection('admins')
            .doc(role.uid)
            .get();

        if (!adminDoc.exists || adminDoc.data() == null) {
      await FirebaseAuth.instance.signOut();
      emit(AuthFailure("هذا الحساب ليس حساب مسؤول"));
      return;
    }    
        adminModel = AdminModel.fromJson(adminDoc.data()!);
    
      emit(AuthSuccess(role: UserTypeEnum.admin, adminModel: adminModel));
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

  Future<void> logout() async {
  emit(AuthLoading());

  try {
    await FirebaseAuth.instance.signOut();

    adminModel = null;

    emailController.clear();
    passwordController.clear();

    emit(AuthInitial());
  } catch (e) {
    emit(AuthFailure("فشل تسجيل الخروج، يرجى المحاولة مرة أخرى"));
  }
 }
}
