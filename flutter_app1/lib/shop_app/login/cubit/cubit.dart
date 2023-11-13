import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model_shop_app/login_model.dart';
import 'package:flutter_app1/shop_app/login/cubit/states.dart';
import 'package:flutter_app1/shop_app/network/end_points/end_points.dart';
import 'package:flutter_app1/shop_app/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email' : email,
        'password' : password,
      },).then((value) {
      print(value.data['message']);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.data.token);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibiliy()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePasswordVisibilityState());
  }

}