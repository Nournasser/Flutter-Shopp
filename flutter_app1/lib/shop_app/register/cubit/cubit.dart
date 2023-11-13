import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model_shop_app/login_model.dart';
import 'package:flutter_app1/shop_app/login/cubit/states.dart';
import 'package:flutter_app1/shop_app/network/end_points/end_points.dart';
import 'package:flutter_app1/shop_app/network/remote/dio_helper.dart';
import 'package:flutter_app1/shop_app/register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,

  })
  {
    emit(ShopRegisterLoadingState());
      DioHelper.postData(
      url: REGISTER,
      data: {
        'name' : name,
        'email' : email,
        'password' : password,
        'phone' : phone,
      },).then((value) {
      print(value.data['message']);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibiliy()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

}