import 'package:elwekala_ecommerce_app/controller/cubit/register.dart';
import 'package:elwekala_ecommerce_app/controller/states/register.dart';
import 'package:elwekala_ecommerce_app/services/cache-helper.dart';
import 'package:elwekala_ecommerce_app/utilities/router.dart';
import 'package:elwekala_ecommerce_app/view//widgets/button.dart';
import 'package:elwekala_ecommerce_app/view//widgets/textfield.dart';
import 'package:elwekala_ecommerce_app/view/screens/bottomnavbar-screen.dart';
import 'package:elwekala_ecommerce_app/view/screens/login-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var nationalId = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSucceed) {
          if (state.userModel.status == 'success') {
            debugPrint(state.userModel.user!.token);
            CacheHelper.saveData(
                key: "token", value: state.userModel.user!.token);
            CacheHelper.saveData(
                key: "nationalId", value: state.userModel.user!.nationalId);
            debugPrint(state.userModel.user!.nationalId);
          }
        }
      },
      builder: (context, state) {
        final cubit = RegisterCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 40.0),
                child: Form(
                  key: cubit.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (cubit.pickedimage == null)
                            MaterialButton(
                              onPressed: () => cubit.getImageFromGallery(),
                              child: Container(
                                height:90 ,
                                width: 150,
                               clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                
                                child: Image.asset("assets/images/nouser.jpg")         
                                ),
                              ),
                             if (cubit.pickedimage != null)
                            Container(
                                height: 90,
                                width: 130,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.file(
                                (cubit.pickedimage)!,
                                 fit: BoxFit.fill,
                              ),
                              ),
                            ]
                            ),
            
                      TextForm(
                          controller: name,
                          textAction: TextInputAction.next,
                          inputType: TextInputType.emailAddress,
                          obscure: false,
                          label: 'Name',
                          hint: 'Enter your full name',
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your name' : null),
                      const SizedBox(
                        height: 10.0,
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
                        height: 10.0,
                      ),
                      TextForm(
                          controller: password,
                          textAction: TextInputAction.none,
                          inputType: TextInputType.visiblePassword,
                          obscure: cubit.visiblePassword,
                          suffixicon: IconButton(
                            icon: cubit.suffixIcon,
                            onPressed: ()=> cubit.changeSuffixIcon(),
                            ),
                          label: 'Password',
                          hint: 'Enter your password',
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your password'
                              : null),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextForm(
                          controller: phone,
                          textAction: TextInputAction.next,
                          inputType: TextInputType.number,
                          obscure: false,
                          label: 'Phone',
                          hint: 'Enter your phone number',
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your phone number'
                              : null),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextForm(
                          controller: nationalId,
                          textAction: TextInputAction.next,
                          inputType: TextInputType.number,
                          obscure: false,
                          label: 'NationalId',
                          hint: 'Enter your nationalId',
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your nationalId'
                              : null),
                      const SizedBox(
                        height: 35.0,
                      ),
                      Button(
                        onpressed: () {
                          if (cubit.formkey.currentState!.validate()) {
                            cubit.createUser(
                              name: name.text,
                              email: email.text,
                              password: password.text,
                              phone: phone.text,
                              nationalId: nationalId.text,
                            );
                            debugPrint(cubit.userimage.toString());
                            navigateTo(context,BottomNavScreen());
                          }
                        },
                        text: 'Register',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: const Text('Have an acount? Login'),
                          onTap: () {
                          navigateTo(context, LoginScreen());
                          },
                        ),
                      ),
                ],
                  ),
                ),
              ),
            ),
          ));
   } );
  }
  
  }

