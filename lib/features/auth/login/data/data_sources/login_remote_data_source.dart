import 'package:ecommerce_app_huma_volve/core/network/api_client%20.dart';
import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_model.dart';

class LoginRemoteDataSource {
  final ApiClient apiClient;

  LoginRemoteDataSource(this.apiClient);

  Future<loginmodel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {
        'email': email,
        'password': password,
      },
    );

    return loginmodel.fromJson(
      Map<String, dynamic>.from(response.data),
    );
  }
}