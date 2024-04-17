import 'package:cached_network_image/cached_network_image.dart';
import 'package:elwekala_ecommerce_app/consts/colors.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/favorite.dart';
import 'package:elwekala_ecommerce_app/model/favorite-model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FavoriteItem extends StatelessWidget {
  FavoriteItem({super.key, required this.favoriteProduct});
  Product? favoriteProduct;
  
  @override
  Widget build(BuildContext context) {
    final favorite = FavoriteCubit.get(context);
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 100,
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
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: CachedNetworkImage(
                      fadeOutCurve: Curves.bounceIn,
                      fit: BoxFit.cover,
                      imageUrl: favoriteProduct?.image ?? "",
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
                  if (favoriteProduct?.sales != 0)
                    Container(
                      width: 95,
                      height: 18,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.zero),
                          color: purple),
                      child:
                          Center(child: Text("${favoriteProduct?.sales}% off")),
                    )
                ]),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        favoriteProduct?.name ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.black),
                      ),
                      Text(favoriteProduct?.company ?? "",
                          style: Theme.of(context).textTheme.bodyMedium!),
                      Text(
                        '\$${favoriteProduct?.price}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey[500]),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  favorite.deleteMyFavorite(
                      favoriteProduct?.sId ?? "");
                },
                icon: const Icon(Icons.delete),
                iconSize: 28.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
