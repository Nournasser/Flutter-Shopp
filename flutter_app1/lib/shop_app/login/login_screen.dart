import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/conistant/conistant.dart';
import 'package:flutter_app1/shop_app/consistant.dart';
import 'package:flutter_app1/shop_app/login/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/login/cubit/states.dart';
import 'package:flutter_app1/shop_app/network/sharedprefrunce/shared_prefrunce.dart';
import 'package:flutter_app1/shop_app/register/register_screen.dart';
import 'package:flutter_app1/shop_app/shop_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status)
            {
              CashHelper.saveDate(key: 'token', value: state.loginModel.data.token).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLayout(),));
                token = state.loginModel.data.token;
              } );
            }
            else
            {
              showToast(
                text: state.loginModel.message,
                color: ToastColors.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          'Login now to browise our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          height: 30.0,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if(value.isEmpty)
                                {
                                  return 'please enter your email adderess';
                                }
                                return null;
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                prefix: Icon(
                                    Icons.email_outlined
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if(value.isEmpty)
                                {
                                  return 'password is too short';
                                }
                                return null;
                              },
                              obscureText: ShopLoginCubit.get(context).isPassword,
                              onEditingComplete: () {
                                if(formKey.currentState.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefix: Icon(
                                    Icons.lock_outline
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(

                                    ShopLoginCubit.get(context).suffix,
                                  ),
                                  onPressed: () {
                                    ShopLoginCubit.get(context).changePasswordVisibiliy();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50.0,
                        ),

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLayout(),));
                              }
                            },
                            child: Text('login'),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(),),
                        ),

                        Row(
                          children: [
                            Text('Don\'t have an account ?'),
                            SizedBox(
                              width: 15.0,
                            ),
                            TextButton(onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                            }, child: Text('Register'),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
