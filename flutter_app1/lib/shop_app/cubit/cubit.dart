import 'package:flutter/material.dart';
import 'package:flutter_app1/model_shop_app/categories_model.dart';
import 'package:flutter_app1/model_shop_app/change_favorites_model.dart';
import 'package:flutter_app1/model_shop_app/favorites_model.dart';
import 'package:flutter_app1/model_shop_app/home_model.dart';
import 'package:flutter_app1/model_shop_app/login_model.dart';
import 'package:flutter_app1/shop_app/categories/categories_screen.dart';
import 'package:flutter_app1/shop_app/consistant.dart';
import 'package:flutter_app1/shop_app/cubit/states.dart';
import 'package:flutter_app1/shop_app/favorite/favorite_screen.dart';
import 'package:flutter_app1/shop_app/network/end_points/end_points.dart';
import 'package:flutter_app1/shop_app/network/remote/dio_helper.dart';
import 'package:flutter_app1/shop_app/products/products_screen.dart';
import 'package:flutter_app1/shop_app/settings/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen =  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.status);
      homeModel.data.products.forEach((element)
      {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = ! favorites[productId];
    emit(ShopChangeFavoritesStates());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        },
      token: token,
    )
        .then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel.status)
        {
          favorites[productId] = !favorites[productId];
        }
      else{
        getFavorites();
      }
          emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel));
    })
        .catchError((error)
    {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesStates());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }

  ShopLoginModel userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataStates());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataStates(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataStates());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone
})
  {
    emit(ShopLoadingUpdateUserStates());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      }
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserStates(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserStates());
    });
  }
}