import 'package:ecommerce_app_huma_volve/features/auth/sign_up/entities/signup_entity.dart';
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupEntity user;

  SignupSuccess(this.user);
}

class SignupFailure extends SignupState {
  final String message;

  SignupFailure(this.message);
}