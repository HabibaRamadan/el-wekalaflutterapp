import 'package:elwekala_ecommerce_app/consts/api-endpoints.dart';
import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/states/favorite.dart';
import 'package:elwekala_ecommerce_app/model/favorite-model.dart';
import 'package:elwekala_ecommerce_app/services/dio-helper.dart';
import 'package:elwekala_ecommerce_app/services/hive-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit(super.initialState);

  static FavoriteCubit get(context) {
    return BlocProvider.of(context);
  }

  FavoriteModel? favoriteModel;
  bool isFavorite = false;
  Future<void> getMyFavorite() async {
    try {
      emit(LoadingGetFavorite());
      await DioHelper.fecthData(
          url: ApiEndPoints.apiGetFavorite,
          data: {"nationalId": nationalId}).then((value) {
        favoriteModel = FavoriteModel.fromJson(value.data);
        debugPrint("${favoriteModel!.favoriteProduct![0].name}");
        emit(SuccedGetFavorite());
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(GetFavoriteError());
    }
  }

  Future<void> addMyFavorite(String productId) async {
    try {
      emit(LoadingAddFavorite());
      await DioHelper.postData(
              url: ApiEndPoints.apiAddFavorite,
              data: {"nationalId": nationalId, "productId": productId})
          .then((value) {
        emit(SuccedAddFavorite());
        getMyFavorite();
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(GetFavoriteError());
    }
  }

  Future<void> deleteMyFavorite(String productId) async {
    try {
      emit(LoadingDeleteFavorite());
      await DioHelper.deleteData(
              url: ApiEndPoints.apiDeleteFavorite,
              data: {"nationalId": nationalId, "productId": productId})
          .then((value) {
        emit(SuccedDeleteFavorite());
        getMyFavorite();
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(DeleteFavoriteError());
    }
  }


  void addOrDeleteFavoritesIds(int? index, String productId) async {
    if (HiveHelper.box!.containsKey(index)) {
      HiveHelper.deleteData(key: index);
      emit(RemoveFromHive());
    } else {
      HiveHelper.putData(key: index, value: productId);
      emit(AddToHive());
    }
  }
}
