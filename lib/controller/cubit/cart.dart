import 'package:elwekala_ecommerce_app/consts/api-endpoints.dart';
import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/states/cart.dart';
import 'package:elwekala_ecommerce_app/model/cart-model.dart';
import 'package:elwekala_ecommerce_app/services/dio-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit(super.initialState);

  CartModel? cartModel;
  static CartCubit get(context) {
    return BlocProvider.of(context);
  }

  Future<void> getFromCart() async {
   try {
    emit(LoadingGetCart());
  await DioHelper.fecthData(
        url: ApiEndPoints.apiGetCart,
        data: {"nationalId": nationalId}).then((value) {
      cartModel = CartModel.fromJson(value.data);
      debugPrint("${cartModel?.products![0].name}");
      emit(SuccedGetCart());
    });
    }catch(e) {
      debugPrint(e.toString());
      emit(GetFromCartError());
    }
  }

  Future<void> addToCart(String productid) async {
    try {
      emit(LoadingAddToCart());
      await DioHelper.postData(url: ApiEndPoints.apiAddCart, data: {
        "productId": productid,
        "nationalId": nationalId,
        "quantity": "1"
      });
      emit(SuccedAddToCart());
      getFromCart();
    } catch (e) {
      debugPrint(e.toString());
      emit(AddToCartError());
    }
  }

  Future<void> deleteFromCart(String productid) async {
    try {
      emit(LoadingDeleteCart());
      await DioHelper.deleteData(url: ApiEndPoints.apiDeleteCart, data: {
        "productId": productid,
        "nationalId": nationalId,
      }).then((value) {
        emit(SuccedDeleteCart());
        getFromCart();
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(DeleteCartError());
    }
  }

  Future<void> upDateCart(String productid,int quantity) async {
    try {
      emit(LoadingUpdateCart());
      await DioHelper.putData(url: ApiEndPoints.apiUpdateCart, data: {
        "productId": productid,
        "nationalId": nationalId,
        "quantity": quantity
      });
      emit(SuccedUpdateCart());
      getFromCart();
    } catch (e) {
      debugPrint(e.toString());
      emit(UpdateCartError());
    }
  }
}
