
import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client .dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_model.dart';

class LoginSevices {
  ApiClient apiClient;
  LoginSevices(this.apiClient);
Future<loginmodel> 
 login({required String email, required String password}) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {"email": email, "password": password},
    );
    final Map<String, dynamic> JsonData = response.data;
    final modelData = loginmodel.fromJson(JsonData);
  
    return modelData;
  }
}
