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

  static const int _limit = 10;

  List<HomeCategoryEntity> categories = [];
  List<HomeProductEntity> products = [];

  int? _currentCategoryId;
  bool _hasReachedMax = false;
  bool _isLoadingMore = false;

  HomeSuccess _success({bool isLoadingMore = false}) => HomeSuccess(
        categories: categories,
        products: products,
        isLoadingMore: isLoadingMore,
        hasReachedMax: _hasReachedMax,
      );

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    try {
      categories = await getCategoriesUseCase.call();

      if (categories.isEmpty) {
        products = [];
        _currentCategoryId = null;
        _hasReachedMax = true;
        emit(_success());
        return;
      }

      await _loadFirstPage(categories.first.id);
      emit(_success());
    } catch (e) {
      emit(HomeError('Failed to load home data: $e'));
    }
  }

  Future<void> loadProducts(int categoryId) async {
    emit(HomeLoading());

    try {
      await _loadFirstPage(categoryId);
      emit(_success());
    } catch (e) {
      emit(HomeError('Failed to load products: $e'));
    }
  }

  Future<void> _loadFirstPage(int categoryId) async {
    _currentCategoryId = categoryId;
    _hasReachedMax = false;
    _isLoadingMore = false;

    final result = await getProductsUseCase.call(
      categoryId,
      offset: 0,
      limit: _limit,
    );

    products = result;
    _hasReachedMax = result.length < _limit;
  }

  Future<void> fetchNextPage() async {
    final categoryId = _currentCategoryId;
    if (categoryId == null || _isLoadingMore || _hasReachedMax) return;
    if (state is! HomeSuccess) return;

    _isLoadingMore = true;
    emit(_success(isLoadingMore: true));

    try {
      final newItems = await getProductsUseCase.call(
        categoryId,
        offset: products.length,
        limit: _limit,
      );

      // لو اليوزر غيّر الكاتيجوري وإحنا بنحمّل، تجاهل النتيجة دي
      if (categoryId != _currentCategoryId) return;

      products = [...products, ...newItems];
      _hasReachedMax = newItems.length < _limit;
      emit(_success());
    } catch (_) {
      if (categoryId == _currentCategoryId) emit(_success());
    } finally {
      _isLoadingMore = false;
    }
  }
}