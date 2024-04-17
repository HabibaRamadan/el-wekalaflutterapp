import 'package:elwekala_ecommerce_app/consts/colors.dart';
import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/logout.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/profile.dart';
import 'package:elwekala_ecommerce_app/controller/states/profile.dart';
import 'package:elwekala_ecommerce_app/utilities/router.dart';
import 'package:elwekala_ecommerce_app/view/screens/login-screen.dart';
import 'package:elwekala_ecommerce_app/view/widgets/button.dart';
import 'package:elwekala_ecommerce_app/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);
          final logOutCubit = LogOutCubit.get(context);
          TextEditingController name =
              TextEditingController(text: cubit.profileModel?.user?.name);
          TextEditingController email =
              TextEditingController(text: cubit.profileModel?.user?.email);
          TextEditingController phone =
              TextEditingController(text: cubit.profileModel?.user?.phone);
          if (state is ProfileUpdateLoading || state is ProfileGetError) {
            return Scaffold(
                appBar: AppBar(
                  title: Center(
                      child: Text(profileTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white))),
                  backgroundColor: lightpurple,
                ),
                body: const Padding(
                    padding: EdgeInsets.all(60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                          color: Colors.purple,
                        )),
                      ],
                    )));
          } else {
            return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        Opacity(
                          opacity: 0.7,
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            color: purple,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    logOutCubit.userLogOut();
                                    navigateTo(context, LoginScreen(),root: true);
                                  },
                                  icon: const Icon(Icons.logout)),
                            ]),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                width: 150,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: cubit.profileModel?.user?.image == null
                                    ? Image.asset('assets/images/nouser.jpg')
                                    : Image.network(
                                        cubit.profileModel?.user?.image ?? "",
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                cubit.profileModel?.user?.name ?? "",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                cubit.profileModel?.user?.email ?? "",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ]),
                      const SizedBox(height: 29),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: cubit.formkey,
                          child: Column(
                            children: [
                              TextForm(
                                controller: name,
                                textAction: TextInputAction.none,
                                inputType: TextInputType.name,
                                obscure: false,
                                label: 'Edit Name',
                                hint: 'Enter your Name',
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextForm(
                                  controller: email,
                                  textAction: TextInputAction.none,
                                  inputType: TextInputType.emailAddress,
                                  obscure: false,
                                  label: 'Edit Email',
                                  hint: 'Enter your Email',
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter your password'
                                      : null),
                              const SizedBox(
                                height: 15,
                              ),
                              TextForm(
                                controller: phone,
                                textAction: TextInputAction.none,
                                inputType: TextInputType.number,
                                obscure: false,
                                label: 'Edit Phone',
                                hint: 'Enter your Phone',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Button(
                        onpressed: () {
                          cubit.upDateUserProfile(
                              name.text, email.text, phone.text);
                        },
                        text: "Edit Profile",
                        width: 300,
                        height: 50,
                      )
                    ],
                  ),
                ));
          }
        });
  }
}
