import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/conistant/conistant.dart';
import 'package:flutter_app1/shop_app/consistant.dart';
import 'package:flutter_app1/shop_app/login/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/network/sharedprefrunce/shared_prefrunce.dart';
import 'package:flutter_app1/shop_app/register/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/register/cubit/states.dart';
import 'package:flutter_app1/shop_app/shop_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState)
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
              print('error');
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
                          'Register',
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          'Register now to browise our hot offers',
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
                                  return 'please enter your name';
                                }
                              },
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'User Name',
                                prefix: Icon(
                                    Icons.person
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
                                  return 'please enter your email adderess';
                                }
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
                              },
                              obscureText: ShopLoginCubit.get(context).isPassword,
                              onEditingComplete: () {
                                if(formKey.currentState.validate())
                                {
                                  ShopRegisterCubit.get(context).userRegister(
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

                                    ShopRegisterCubit.get(context).suffix,
                                  ),
                                  onPressed: () {
                                  },
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
                                  return 'please enter your phone';
                                }
                              },
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                prefix: Icon(
                                    Icons.phone
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLayout(),));
                              }
                            },
                            child: Text('Register'),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
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
