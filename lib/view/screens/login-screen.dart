import 'package:elwekala_ecommerce_app/controller/cubit/login.dart';
import 'package:elwekala_ecommerce_app/controller/states/login.dart';
import 'package:elwekala_ecommerce_app/services/cache-helper.dart';
import 'package:elwekala_ecommerce_app/utilities/router.dart';
import 'package:elwekala_ecommerce_app/view//widgets/button.dart';
import 'package:elwekala_ecommerce_app/view//widgets/textfield.dart';
import 'package:elwekala_ecommerce_app/view/screens/bottomnavbar-screen.dart';
import 'package:elwekala_ecommerce_app/view/screens/register-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSucceed) {
          if (state.userModel.status == 'success') {
            debugPrint(state.userModel.user!.token);
            CacheHelper.saveData(
                key: 'token', value: state.userModel.user!.token);
            CacheHelper.saveData(
                key: "nationalId", value: state.userModel.user!.nationalId);
            debugPrint(state.userModel.user!.nationalId);
          }
        }
      },
      builder: (context, state) {
        final cubit = LoginCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Form(
                  key: cubit.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text('Login',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(
                        height: 40,
                      ),
                      TextForm(
                          controller: email,
                          textAction: TextInputAction.next,
                          inputType: TextInputType.emailAddress,
                          obscure: false,
                          label: 'Email',
                          hint: 'Enter your email',
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your email'
                              : null),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextForm(
                          controller: password,
                          textAction: TextInputAction.none,
                          inputType: TextInputType.visiblePassword,
                          obscure: cubit.isPassword,
                          label: 'Password',
                          hint: 'Enter your password',
                          suffixicon: IconButton(
                            icon: cubit.suffixIcon,
                            onPressed:()=> cubit.changeSuffixIcon(),
                          ),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your password'
                              : null),
                      const SizedBox(
                        height: 70.0,
                      ),
                      Center(
                        child: Button(
                          onpressed: () {
                            if (cubit.formkey.currentState!.validate()) {
                              cubit.fecthUser(
                                  email: email.text, password: password.text);
                            }
                            navigateTo(context, BottomNavScreen());
                            cubit.clearFeilds(email, password);
                          },
                          text: 'Login',
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: const Text('Don\'t have an acount? Register'),
                          onTap: () {
                            navigateTo(context, RegisterScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
