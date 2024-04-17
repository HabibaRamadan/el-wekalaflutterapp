import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/favorite.dart';
import 'package:elwekala_ecommerce_app/controller/states/favorite.dart';
import 'package:elwekala_ecommerce_app/view/widgets/favorite-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = FavoriteCubit.get(context);
          if (state is LoadingGetFavorite || state is GetFavoriteError  ){
            return Scaffold(
              appBar: AppBar(
                title: Center(
                    child: Text(favoriteTite,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white))),
                backgroundColor: lightpurple,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body:const Padding(
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
          } 
            return Scaffold(
              appBar: AppBar(
                title: Center(
                    child: Text(favoriteTite,
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
                        itemCount: cubit.favoriteModel?.favoriteProduct?.length ,
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FavoriteItem(
                                favoriteProduct: cubit.favoriteModel?.favoriteProduct?[index],
                                )
                            )
                       )
                  ],
                ),
              ),
            );
          
        });
  }
}