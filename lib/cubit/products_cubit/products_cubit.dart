import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fifteenbucks/model/product_model.dart';
import 'package:fifteenbucks/server_interaction/get_products.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  
  
  getProducts()async{
    emit(ProductsLoading());
    ProductModel productModel = await  Server().getProducts('watches');
    if(productModel.products !=null){
      emit(ProductsSuccessState(productModel));
    }else{
      emit(ProductsFailedState());
    }
  }
}
