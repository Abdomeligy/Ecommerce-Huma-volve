
import '../../domain/entities/home_category_entity.dart';
import '../../domain/entities/home_product_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_sources/home_remote_data_source.dart';
import '../../services/models/category_model.dart';
import '../../services/models/products_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<HomeCategoryEntity>> getCategories() async {
    final categoriesJson = await remoteDataSource.getCategories();

    return categoriesJson.map((json) {
      final categoryModel = Categorymodel.fromJson(
        Map<String, dynamic>.from(json as Map),
      );

      return categoryModel.toEntity();
    }).toList();
  }

  @override
  Future<List<HomeProductEntity>> getProducts(int categoryId) async {
    final productsJson = await remoteDataSource.getProducts(categoryId);

    return productsJson.map((json) {
      final productModel = Productsmodel.fromJson(
        Map<String, dynamic>.from(json as Map),
      );

      return productModel.toEntity();
    }).toList();
  }
}
