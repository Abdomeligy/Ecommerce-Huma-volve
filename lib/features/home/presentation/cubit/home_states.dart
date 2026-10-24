
import '../../domain/entities/home_category_entity.dart';
import '../../domain/entities/home_product_entity.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<HomeCategoryEntity> categories;
  final List<HomeProductEntity> products;

  HomeSuccess({
    required this.categories,
    required this.products,
  });
}

class HomeError extends HomeStates {
  final String message;

  HomeError(this.message);
}
