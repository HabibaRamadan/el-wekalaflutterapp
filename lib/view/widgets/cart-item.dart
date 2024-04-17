import 'package:cached_network_image/cached_network_image.dart';
import 'package:elwekala_ecommerce_app/consts/colors.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/cart.dart';
import 'package:elwekala_ecommerce_app/model/cart-model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CartItem extends StatelessWidget {
  CartItem({super.key, required this.cart});
  CartProducts ?cart;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 95,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  border: Border.all(color: purple, style: BorderStyle.solid),
                ),
                child: Stack(
                 alignment: Alignment.bottomCenter,
                 children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: CachedNetworkImage(
                      fadeOutCurve: Curves.bounceIn,
                      fit: BoxFit.cover,
                      imageUrl: cart?.image ?? "",
                      imageBuilder: (context, imageProvider) =>
                          Image(image: imageProvider),
                      errorWidget: (context, url, error) {
                        debugPrint(error.toString());
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.grey,
                        ));
                      },
                    ),
                  ),
                  if (cart?.sales != 0)
                    Container(
                      width: 95,
                      height: 18,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.zero),
                          color: purple),
                      child: Center(child: Text("${cart?.sales}% off")),
                    )
                ]),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      cart?.name ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      '\$${cart?.totalPrice}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey[500]),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                CartCubit.get(context)
                                    .deleteFromCart(cart?.sId??"");
                              },
                              icon: const Icon(Icons.delete)),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Opacity(
                            opacity: cart?.quantity == 1 ? 0.4 : 1.0,
                            child: IconButton.outlined(
                                onPressed: () {
                                  cart?.quantity == 1
                                      ? null
                                      : CartCubit.get(context).upDateCart(
                                          cart?.sId ?? "", --cart?.quantity);
                                },
                                icon: cart?.quantity == 1
                                    ? Icon(Icons.remove,
                                        color: Colors.grey.withOpacity(0.4))
                                    : Icon(Icons.remove,
                                        color: Colors.grey[600])),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Text(
                            "${cart?.quantity}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          IconButton.outlined(
                              onPressed: () {
                                CartCubit.get(context).addToCart(cart?.sId??"");
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
