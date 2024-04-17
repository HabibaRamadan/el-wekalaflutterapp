import 'package:elwekala_ecommerce_app/consts/api-endpoints.dart';
import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/states/logout.dart';
import 'package:elwekala_ecommerce_app/services/cache-helper.dart';
import 'package:elwekala_ecommerce_app/services/dio-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogOutCubit extends Cubit<LogOutStates> {
  LogOutCubit(super.initialState);

  static LogOutCubit get(context) {
    return BlocProvider.of(context);
  }


  Future<void> userLogOut() async {
    try {
      emit(LoadingLogOut()); 
      await DioHelper.postData(
          url: ApiEndPoints.apiLogOut, data: {"nationalId": nationalId})
          .then((value) {
        debugPrint("user logged out succesfuly");
          CacheHelper.deleteData(key:"token" );
        emit(SuccedLogOut());
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorLogOut());
    }
  }
}
