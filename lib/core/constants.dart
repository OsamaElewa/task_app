
import 'package:flutter/material.dart';
import 'package:taskapp/modules/login_screen/login_screen.dart';

import 'cache_helper.dart';

var token;

void signOut(context)
{
  CacheHelper.clearData(key: 'token').then((value){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
  });
}