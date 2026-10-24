
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/entities/signup_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/repositories/signup_repository.dart';

class SignupUseCase {
  final SignupRepository repository;

  SignupUseCase(this.repository);

  Future<SignupEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.signUp(
      name: name,
      email: email,
      password: password,
    );
  }
}
