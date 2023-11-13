import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/conistant/conistant.dart';
import 'package:flutter_app1/shop_app/consistant.dart';
import 'package:flutter_app1/shop_app/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  if(state is ShopLoadingUpdateUserStates)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (String value) {
                      if(value.isEmpty)
                      {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Name ',
                      prefix: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (String value) {
                      if(value.isEmpty)
                      {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'email Address ',
                      prefix: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (String value) {
                      if(value.isEmpty)
                      {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number ',
                      prefix: Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: (){

                        if(formKey.currentState.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                            );
                          }
                      },
                      text: 'Update'
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: (){
                      signOut(context);
                    },
                    text: 'Logout'
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
