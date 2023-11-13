import 'package:flutter/material.dart';
import 'package:flutter_app1/shop_app/consistant.dart';
import 'package:flutter_app1/shop_app/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/cubit/states.dart';
import 'package:flutter_app1/shop_app/login/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/login/login_screen.dart';
import 'package:flutter_app1/shop_app/network/remote/dio_helper.dart';
import 'package:flutter_app1/shop_app/network/sharedprefrunce/shared_prefrunce.dart';
import 'package:flutter_app1/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_app1/shop_app/register/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/shop_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;
  bool onBoarding = CashHelper.getData(key: 'onBoarding');
  token = CashHelper.getData(key: 'token');
  print(onBoarding);
  print(token);


  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = LoginScreen();
  }
  else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({
    @required this.startWidget,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ( context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: ( context) => ShopRegisterCubit(),
        ),
        BlocProvider(
          create: ( context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: startWidget ,
          );
        },
      ),
    );
  }
}



