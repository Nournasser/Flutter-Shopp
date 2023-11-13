import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model_shop_app/categories_model.dart';
import 'package:flutter_app1/shop_app/consistant.dart';
import 'package:flutter_app1/shop_app/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCategoriesItem(ShopCubit.get(context).categoriesModel.data.data[index]),
            separatorBuilder: (context, index) => defaultSeparator(),
            itemCount: ShopCubit.get(context).categoriesModel.data.data.length);
      },
    );
  }
}


Widget buildCategoriesItem(DataModel model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
        image: NetworkImage(model.image),
        height: 80.0,
        width: 80.0,
        fit: BoxFit.cover,
      ),
      SizedBox(
        width: 20.0,
      ),
      Text(
        model.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      ),

    ],
  ),
);