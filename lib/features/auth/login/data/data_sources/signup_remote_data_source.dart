import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client%20.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_res_model.dart';

class SignupRemoteDataSource {
  final ApiClient apiClient;

  SignupRemoteDataSource(this.apiClient);

  Future<signupResmodel> signUp(
    SignupReqModel request,
  ) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signupEndpoint,
      data: {
        'name': request.name,
        'email': request.email,
        'password': request.password,
        'avatar':
            'https://i.pravatar.cc/300',
      },
    );

    return signupResmodel.fromJson(
      Map<String, dynamic>.from(response.data),
    );
  }
}