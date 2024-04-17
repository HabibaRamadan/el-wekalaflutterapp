import 'package:elwekala_ecommerce_app/controller/states/login.dart';
import 'package:elwekala_ecommerce_app/model/user-model.dart';
import 'package:elwekala_ecommerce_app/services/dio-helper.dart';
import 'package:elwekala_ecommerce_app/consts/api-endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(super.initialState);
  User? user;
  final formkey = GlobalKey<FormState>();
  bool isPassword = true;
  Widget suffixIcon = const Icon(Icons.visibility_off);
  static LoginCubit get(context) {
    return BlocProvider.of(context);
  }

  Future<void> fecthUser({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoadingLogin());
      await DioHelper.postData(
        url: ApiEndPoints.apiLogIn,
        data: {
          "email": email,
          "password": password,
        },
      ).then((value) {
        UserModel model = UserModel.fromJson(value.data);
        emit(LoginSucceed(model));
        debugPrint('user logged in  succefully ');
        debugPrint(model.user!.token.toString());
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(LoginError());
    }
  }

  changeSuffixIcon() {
    if (isPassword == true) {
      suffixIcon = const Icon(Icons.visibility);
      isPassword = !isPassword;
    } else {
      suffixIcon = const Icon(Icons.visibility_off);
      isPassword = !isPassword;
    }
    emit(ChangeSuffixIcon());
  }

  void clearFeilds(
      TextEditingController email, TextEditingController password) {
    email.clear();
    password.clear();
    emit(ClearFields());
  }
}
