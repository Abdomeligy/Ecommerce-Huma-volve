
import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client%20.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/products_model.dart';

class HomeService {
  final ApiClient apiClient;
  HomeService(this.apiClient);

  Future<List<Categorymodel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoryEndpoint);
    final List JsonData = response.data;
    final List<Categorymodel> categories = JsonData.map(
      (e) => Categorymodel.fromJson(e),
    ).toList();
    return categories;
  }

  Future<List<Productsmodel>> getproducts(int categoryId) async {
    final response = await apiClient.dio.get(
      "{ApiEndpoints.categoriesEndpoint}/$categoryId/${ApiEndpoints.productsEndpoint}",
    );

    final List JsonData = response.data;
    final List<Productsmodel> products = JsonData.map(
      (e) => Productsmodel.fromJson(e),
    ).toList();
    return products;
  }
}
