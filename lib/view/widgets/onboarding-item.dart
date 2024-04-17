import 'package:elwekala_ecommerce_app/model/onboarding-model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnBoardingItem extends StatelessWidget {
   
  OnBoardingModel? model;

  OnBoardingItem( this.model, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Image.asset(model!.image?? '',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model!.title ??'',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model!.subtitle ??'',
            style: Theme.of(context).textTheme.bodyMedium,
          ) 
        ],
      ),
    );
  }
}
