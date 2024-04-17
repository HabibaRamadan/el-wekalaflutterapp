import 'package:elwekala_ecommerce_app/consts/colors.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/favorite.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/product.dart';
import 'package:elwekala_ecommerce_app/model/product-model.dart';
import 'package:elwekala_ecommerce_app/services/hive-helper.dart';
import 'package:elwekala_ecommerce_app/utilities/router.dart';
import 'package:elwekala_ecommerce_app/view/screens/productdetails-screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive_flutter/adapters.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  ProductItem({super.key, required this.product, required this.index});
  Product product;
  int index;
  @override
  Widget build(BuildContext context) {
    final favorite = FavoriteCubit.get(context);
    return GestureDetector(
      onTap: () {
        final productItem = ProductCubit.get(context).getProductId(product.sId);
        navigateTo(context, const ProductDetails(),
            argu: productItem, root: true);
      },
      child: Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 10.0),
                    child: ClipRect(
                      child: SizedBox(
                        width: 120,
                        height: 95,
                        child: Center(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:
                                product.image == null ? "" : product.image!,
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
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (product.status == "New")
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              RotatedBox(
                                quarterTurns: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Opacity(
                                    opacity: 0.30,
                                    child: Container(
                                      width: 80,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: purple,
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 5,
                                child: Text(
                                  '${product.status}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.purple[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.sales != 0)
                      Container(
                        width: 50,
                        height: 21,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Center(
                            child: Text(
                          '${product.sales}%',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                        )),
                      ),
                    SizedBox(
                      width: 111,
                      child: Text(
                        product.name ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    Text(
                      '${product.price}\$',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                        valueListenable:HiveHelper.box!.listenable() ,
                        builder: (context, box , child){ 
                           return  IconButton(
                            iconSize: 25.0,
                            icon:box.containsKey(index)?const Icon( Icons.favorite,color: Colors.red)
                            :const Icon( Icons.favorite, color: Colors.grey, ),
                            onPressed: () {
                              if (box.containsKey(index)) {  
                               favorite.deleteMyFavorite(product.sId ?? "");
                                favorite.addOrDeleteFavoritesIds(
                                    index, product.sId ?? "");
                              }else {  
                              favorite.addMyFavorite(product.sId ?? "");
                              favorite.addOrDeleteFavoritesIds(
                                  index, product.sId ?? "");}
                            });
                            }
                      ),
                    ],
                )
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
