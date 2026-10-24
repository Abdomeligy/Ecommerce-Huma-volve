
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/home_category_entity.dart';
import '../../domain/entities/home_product_entity.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  List<HomeCategoryEntity> categories = [];
  List<HomeProductEntity> products = [];

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    try {
      categories = await getCategoriesUseCase.call();

      if (categories.isEmpty) {
        products = [];
        emit(HomeSuccess(
          categories: categories,
          products: products,
        ));
        return;
      }

      final categoryId = categories.first.id;
      products = await getProductsUseCase.call(categoryId);

      emit(HomeSuccess(
        categories: categories,
        products: products,
      ));
    } catch (e) {
      emit(HomeError('Failed to load home data: $e'));
    }
  }

  Future<void> loadProducts(int categoryId) async {
    emit(HomeLoading());

    try {
      products = await getProductsUseCase.call(categoryId);

      emit(HomeSuccess(
        categories: categories,
        products: products,
      ));
    } catch (e) {
      emit(HomeError('Failed to load products: $e'));
    }
  }
}
