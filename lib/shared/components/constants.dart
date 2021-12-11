
import 'package:flutter/material.dart';
import 'package:mar_stor/modules/shop_app/shop_login/login_screen.dart';
import 'package:mar_stor/shared/network/local/cache_helper.dart';

import 'components.dart';

///Get
///Post
///Update
///Delete
/// base url : https://newsapi.org/
/// method(url) : v2/top-headlines?
/// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca



// void signOut(context){
//   CacheHelper.removeData(key: 'token');
//   token=null;
//   navigateAndFinish(context, ShopLoginScreen(),);
//
// }
void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
       navigateAndFinish(
        context,
        ShopLoginScreen(),
      );
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

String uId = '';