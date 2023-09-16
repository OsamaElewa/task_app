import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/modules/home_screen/home_screen.dart';
import 'package:taskapp/modules/login_screen/login_screen.dart';

import 'bloc_observer.dart';
import 'core/cache_helper.dart';
import 'core/constants.dart';
import 'core/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  token=CacheHelper.getData(key: 'token');
  print(token);
  if(token!=null)
  {
    widget=const HomeScreen();
  }
  else{
    widget=LoginScreen();
  }
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: startWidget,
    );
  }
}
