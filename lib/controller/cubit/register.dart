import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:elwekala_ecommerce_app/controller/states/register.dart';
import 'package:elwekala_ecommerce_app/model/user-model.dart';
import 'package:elwekala_ecommerce_app/services/dio-helper.dart';
import 'package:elwekala_ecommerce_app/consts/api-endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(super.initialState);
  User? user;
  File? pickedimage;
  String? userimage;
  Uint8List? bytes;
  bool visiblePassword = true;
 Widget suffixIcon = const Icon(Icons.visibility_off);

  final formkey = GlobalKey<FormState>();

  static RegisterCubit get(context) {
    return BlocProvider.of(context);
  }

  void createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String nationalId,
  }) async {
    try {
      emit(RegisterLoading());
      await DioHelper.postData(
        url: ApiEndPoints.apiRegister,
        data: {
          "email": email,
          "password": password,
          "phone": phone,
          "name": name,
          "gender": "female",
          "nationalId": nationalId,
          "profileImage": userimage
        },
      ).then((value) {
        UserModel model = UserModel.fromJson(value.data);
        emit(RegisterSucceed(model));
        debugPrint(model.user!.name);
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(RegisterError());
    }
  }

  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    try {
      if (image != null) {
        pickedimage = File(image.path);
        bytes = File(pickedimage!.path).readAsBytesSync();
        userimage = base64Encode(bytes!);
        emit(ImageChosen());
      }
    } catch (e) {
      debugPrint('errorimage: ${e.toString()}');
    }
  }

  changeSuffixIcon() {
    if (visiblePassword == true) {
      suffixIcon = const Icon(Icons.visibility);
      visiblePassword = !visiblePassword;
      }else{
      suffixIcon = const Icon(Icons.visibility_off);
      visiblePassword = !visiblePassword;
      
    }
    emit(ChangeSuffixIcon());
  }
}
