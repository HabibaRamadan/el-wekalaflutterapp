import 'package:elwekala_ecommerce_app/consts/api-endpoints.dart';
import 'package:elwekala_ecommerce_app/controller/states/profile.dart';
import 'package:elwekala_ecommerce_app/model/user-model.dart';
import 'package:elwekala_ecommerce_app/services/dio-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwekala_ecommerce_app/consts/data.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(super.initialState);

  static ProfileCubit get(context) {
    return BlocProvider.of(context);
  }

  final formkey = GlobalKey<FormState>();
  UserModel? profileModel;

  Future<void> getUserProfile() async {
    try {
      emit(ProfileGetLoading());
      DioHelper.postData(url: ApiEndPoints.apiProfile, data: {"token": token})
          .then((value) {
        profileModel = UserModel.fromJson(value.data);
        debugPrint(profileModel?.user?.email);
        emit(ProfileGetSucceed());
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(ProfileGetError());
    }
  }

  Future<void> upDateUserProfile(
      String? name, String? email, String? phone) async {
    try {
      emit(ProfileUpdateLoading());
      DioHelper.putData(url: ApiEndPoints.apiEditProfile, data: {
        "token": token,
        "name": name,
        "email": email,
        "phone": phone,
        "gender": "female",
        "password": "1234567"
      }).then((value) {
        emit(ProfileUpdateSucceed());
        getUserProfile();
        debugPrint(profileModel?.user?.name);
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(ProfileUpdateError());
    }
  }

  
}
