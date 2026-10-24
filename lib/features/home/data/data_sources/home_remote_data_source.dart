
import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client%20.dart';

class HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSource(this.apiClient);

  Future<List<dynamic>> getCategories() async {
    final response = await apiClient.dio.get(
      ApiEndpoints.categoryEndpoint,
    );

    return response.data as List<dynamic>;
  }

  Future<List<dynamic>> getProducts(int categoryId) async {
    final response = await apiClient.dio.get(
      ApiEndpoints.productsEndpoint,
      queryParameters: {'categoryId': categoryId},
    );

    return response.data as List<dynamic>;
  }
}
