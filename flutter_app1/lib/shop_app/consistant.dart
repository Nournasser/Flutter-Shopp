import 'package:flutter/material.dart';
import 'package:flutter_app1/shop_app/login/login_screen.dart';
import 'package:flutter_app1/shop_app/network/sharedprefrunce/shared_prefrunce.dart';



void signOut(context)
{
  CashHelper.removeData(key: 'token').then((value) => (value) {
    if (value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget defaultSeparator() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);


String token = '';