// ignore_for_file: iterable_contains_unrelated_type

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elwekala_ecommerce_app/consts/colors.dart';
import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/cart.dart';
import 'package:elwekala_ecommerce_app/model/product-model.dart';
import 'package:elwekala_ecommerce_app/utilities/router.dart';
import 'package:elwekala_ecommerce_app/view/screens/cart-screen.dart';
import 'package:elwekala_ecommerce_app/view/widgets/button.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Center(child: Text(productTitle)),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CarouselSlider(
                    items: product.images!
                        .map((e) => Container(
                              width: 300,
                              height: 320,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: purple, style: BorderStyle.solid)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  colorBlendMode: BlendMode.colorDodge,
                                  imageUrl: e,
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
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 198,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
              SingleChildScrollView(
                child: Flexible(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? "",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.description ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey),
                          ),
                        )
                      ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    product.company ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18.0),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                 Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  '${product.price}\$',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ), 
                ],
              ),
              
              const SizedBox(height: 20.0),
              Center(
                child: Button(
                  onpressed: () {
                    CartCubit.get(context).addToCart(product.sId ?? "");
                    navigateTo(context, const CartScreen());
                  },
                  text: 'Add To Cart',
                  width: 300,
                ),
              )
            ],
          ),
        ));
  }
}
