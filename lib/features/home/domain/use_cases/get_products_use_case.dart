
import '../entities/home_product_entity.dart';
import '../repository/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<HomeProductEntity>> call(int categoryId) {
    return repository.getProducts(categoryId);
  }
}
