import 'package:ecommerce_app_huma_volve/features/home/Cubit/home_states.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitial());

  void loadingHomeData() async {
    emit(CategoriesLoading());
    try {
      final Categories = await homeService.getCategories();
      emit(CategoriesSuccess(Categories));
      final products = await homeService.getproducts(Categories[0].hashCode);
      emit(productSuccess(products));
    } catch (e) {
      emit(productError(e.toString()));
    }
  }

  void getproductsBycatogryId(int id) async {
    emit(productLoading());
    try {
      final products = await homeService.getproducts(id);
      emit(productSuccess(products));
    } catch (e) {
      emit(productError(e.toString()));
    }
  }
}
