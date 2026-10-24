
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_sources/signup_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/entities/signup_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/repositories/signup_repository.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_req_model.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource remoteDataSource;

  SignupRepositoryImpl(this.remoteDataSource);

  @override
  Future<SignupEntity> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final model = await remoteDataSource.signUp(
      SignupReqModel(
        name: name,
        email: email,
        password: password,
      ),
    );

    return SignupEntity(
      id: model.id,
      email: model.email,
      name: model.name,
      role: model.role,
      avatar: model.avatar,
      creationAt: model.creationAt,
      updatedAt: model.updatedAt,
    );
  }
}
