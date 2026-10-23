import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/products_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class CategoriesLoading extends HomeStates {}

class CategoriesSuccess extends HomeStates {
  final List<Categorymodel> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesError extends HomeStates {
  final String errorMassage;
  CategoriesError(this.errorMassage);
}


class productLoading  extends HomeStates{
  
}
class productSuccess extends HomeStates {
  final List<Productsmodel> products;
  productSuccess(this.products);
}
class  productError extends HomeStates {
    final String errorMassage;
  productError(this.errorMassage);

}