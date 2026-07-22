import 'package:sihati/features/auth/models/admin_model.dart';
import 'package:sihati/features/auth/models/coRep_model.dart';
import 'package:sihati/features/auth/models/user_type_enum.dart';

class Authstate {}

class AuthInitial extends Authstate {}

class AuthLoading extends Authstate {}

class AuthSuccess extends Authstate {
  final UserTypeEnum role;
  final AdminModel? adminModel;
  final CoRepModel? coRepModel;

  AuthSuccess({required this.role, required this.adminModel, required this.coRepModel});

}

class AuthFailure extends Authstate {
  final String errorMessage;

  AuthFailure(this.errorMessage);
}