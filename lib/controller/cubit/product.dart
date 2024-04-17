import 'package:elwekala_ecommerce_app/consts/api-endpoints.dart';
import 'package:elwekala_ecommerce_app/controller/states/product.dart';
import 'package:elwekala_ecommerce_app/model/product-model.dart';
import 'package:elwekala_ecommerce_app/services/dio-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit(super.initialState);
  ProductModel? productModel;
  bool show = false;
  
  static ProductCubit get(context) {
    return BlocProvider.of(context);
  }

  Future<void> getProducts() async {
   
    try {
     emit(LoadingProduct()); 
      await DioHelper.fecthData(url: ApiEndPoints.apiProduct).then((value) {
        productModel = ProductModel.fromJson(value.data);
        debugPrint(productModel!.product![1].name);
        emit(ProductSucceed());
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(GetProductError());
    }
  }

  Product getProductId(String? id) {
    Product product =
        productModel!.product!.singleWhere((element) => element.sId == id);
    return product;
  }
}
