import '../entities/home_product_entity.dart';
import '../repository/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<HomeProductEntity>> call(
    int categoryId, {
    required int offset,
    required int limit,
  }) {
    return repository.getProducts(categoryId, offset: offset, limit: limit);
  }
}