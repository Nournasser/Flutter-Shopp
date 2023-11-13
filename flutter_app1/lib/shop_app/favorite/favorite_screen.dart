import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/conistant/conistant.dart';
import 'package:flutter_app1/model_shop_app/favorites_model.dart';
import 'package:flutter_app1/shop_app/consistant.dart';
import 'package:flutter_app1/shop_app/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is ! ShopLoadingGetFavoritesStates,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel.data.data[index].product, context),
              separatorBuilder: (context, index) => defaultSeparator(),
              itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

