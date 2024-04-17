import 'package:elwekala_ecommerce_app/consts/colors.dart';
import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/cart.dart';
import 'package:elwekala_ecommerce_app/controller/states/cart.dart';
import 'package:elwekala_ecommerce_app/view/widgets/cart-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CartCubit.get(context);
          if (state is LoadingGetCart || state is GetFromCartError ) {
            return Scaffold(
              appBar: AppBar(
                title: Center(
                    child: Text(cartTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white))),
                backgroundColor: lightpurple,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              appBar: AppBar(
                title: Center(
                    child: Text(cartTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white))),
                backgroundColor: lightpurple,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: cubit.cartModel?.products?.length,
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CartItem(
                                cart: cubit.cartModel?.products?[index])))
                  ],
                ),
              ),
            );
          }
        });
  }
}
