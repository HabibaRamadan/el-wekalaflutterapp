


import 'package:elwekala_ecommerce_app/model/user-model.dart';

abstract class RegisterStates{}
class RegisterInitState extends RegisterStates{}
class RegisterLoading extends RegisterStates{}
class RegisterSucceed extends RegisterStates{
  final UserModel userModel;
  RegisterSucceed(this.userModel);
}
class RegisterError extends RegisterStates{}


class ImageChosen extends RegisterStates{}

class ClearFields extends RegisterStates{}

class ChangeSuffixIcon extends RegisterStates{}
