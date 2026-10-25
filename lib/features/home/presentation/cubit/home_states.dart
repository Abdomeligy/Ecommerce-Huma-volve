import '../../domain/entities/home_category_entity.dart';
import '../../domain/entities/home_product_entity.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<HomeCategoryEntity> categories;
  final List<HomeProductEntity> products;
  final bool isLoadingMore;
  final bool hasReachedMax;

  HomeSuccess({
    required this.categories,
    required this.products,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });
}

class HomeError extends HomeStates {
  final String message;
  HomeError(this.message);
}