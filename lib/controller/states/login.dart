

import 'package:elwekala_ecommerce_app/model/user-model.dart';

abstract class LoginStates{}
class LoginInitState extends LoginStates{}
class LoadingLogin extends LoginStates{}
class LoginSucceed extends LoginStates{
  final UserModel userModel;
  LoginSucceed(this.userModel);
}
class LoginError extends LoginStates{}

class ChangeSuffixIcon extends LoginStates{}
class ClearFields extends LoginStates{}
