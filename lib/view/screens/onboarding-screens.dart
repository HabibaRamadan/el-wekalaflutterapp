import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/onboarding.dart';
import 'package:elwekala_ecommerce_app/controller/states/onboarding.dart';
import 'package:elwekala_ecommerce_app/services/cache-helper.dart';
import 'package:elwekala_ecommerce_app/utilities/router.dart';
import 'package:elwekala_ecommerce_app/view//widgets/button.dart';
import 'package:elwekala_ecommerce_app/view/widgets/onboarding-item.dart';
import 'package:elwekala_ecommerce_app/view/screens/login-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreens extends StatelessWidget {
  const OnBoardingScreens({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = OnBoardingCubit.get(context);
        final onboardingcontroller = PageController();
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                child: PageView.builder(
                  itemBuilder: (context, index) =>
                      OnBoardingItem(onBoardingList[index]),
                  itemCount: onBoardingList.length,
                  controller: onboardingcontroller,
                  onPageChanged: (index) {
                    if (index == onBoardingList.length - 1) {
                      cubit.lastPage(index, context);
                      
                    } else {
                      cubit.notlastPage(index);
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                ),
              ),
              const SizedBox(height:25 ),
               SmoothPageIndicator(
                controller: onboardingcontroller,
                count: onBoardingList.length,
                 effect: const WormEffect(
                    dotColor: CupertinoColors.systemPurple,
                    dotHeight: 16,
                     dotWidth: 16,
                   type: WormType.thinUnderground,
              ),
            ), 
            const SizedBox(height: 25,),          
              if (cubit.islast == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Button(
                        onpressed: () {
                          CacheHelper.saveData(key: 'onboarding', value: true);
                          navigateTo(context, LoginScreen());
                        },
                        text: 'start',
                        width: 150,
                        height: 40,
                      ),
                    )
                  ],
                )
            ],
          ),
        );
      },
    );
  }
}
