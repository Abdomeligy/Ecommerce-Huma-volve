import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app_huma_volve/features/auth/sign_up/use_cases/signup_use_case.dart';
import 'signup_states.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;

  SignupCubit(this.signupUseCase) : super(SignupInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());

    try {
      final result = await signupUseCase(
        name: name,
        email: email,
        password: password,
      );

      emit(SignupSuccess(result));
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}