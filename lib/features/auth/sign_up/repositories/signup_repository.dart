import '../entities/signup_entity.dart';

abstract class SignupRepository {
  Future<SignupEntity> signUp({
    required String name,
    required String email,
    required String password,
  });
}