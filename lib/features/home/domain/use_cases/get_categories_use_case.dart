
import '../entities/home_category_entity.dart';
import '../repository/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<HomeCategoryEntity>> call() {
    return repository.getCategories();
  }
}
