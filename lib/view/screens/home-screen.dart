import 'package:elwekala_ecommerce_app/consts/colors.dart';
import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/product.dart';
import 'package:elwekala_ecommerce_app/controller/states/product.dart';
import 'package:elwekala_ecommerce_app/view/widgets/product-item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = ProductCubit.get(context);
          if (state is LoadingProduct){
            return  Scaffold(
              appBar: AppBar(
              title:  Center(child: Text(homeTitle,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white))),
              backgroundColor: lightpurple,
              ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body:const Padding(
                padding: EdgeInsets.all(60.0),
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator(color: Colors.purple,)),
                  ],
                )
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title:  Center(child: Text(homeTitle,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white))),
              backgroundColor: lightpurple,
              ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GridView.count(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    children: List.generate(
                        cubit.productModel!.product!.length,
                        (index) =>
                            ProductItem(product: cubit.productModel!.product![index],index: index,)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
