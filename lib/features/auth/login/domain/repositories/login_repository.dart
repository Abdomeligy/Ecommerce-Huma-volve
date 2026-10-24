import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<LoginEntity> login({
    required String email,
    required String password,
  });
}