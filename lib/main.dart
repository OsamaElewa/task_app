import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/modules/add_new_task/add_new_task.dart';
import 'package:taskapp/modules/admin_home_page/admin_cubit/admin_cubit.dart';
import 'package:taskapp/modules/admin_home_page/admin_home_page.dart';
import 'package:taskapp/modules/all_department/all_dep_cubit/all_dep_cubit.dart';
import 'package:taskapp/modules/all_user/all_user_cubit/all_user_cubit.dart';
import 'package:taskapp/modules/home_screen/home_screen.dart';
import 'package:taskapp/modules/login_screen/login_screen.dart';
import 'package:taskapp/modules/new_department/department_cubit/department_cubit.dart';
import 'package:taskapp/modules/update_department/update_department_cubit/update_department_cubit.dart';
import 'package:taskapp/modules/update_user/update_user_cubit/update_user_cubit.dart';
import 'package:taskapp/modules/user_home_page/user_home_page.dart';

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
    widget=const AdminHomePage();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AllDepartmentCubit()..getDepartments(),),
        BlocProvider(create: (context) => AllUserCubit()..getUsers(),),
        BlocProvider(create: (context) => UpdateUserCubit(),),
        BlocProvider(create: (context) => UpdateDepartmentCubit(),),
        BlocProvider(create: (context) => AdminCubit()..getAllallTypeEmployees()..getAllTasks(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: startWidget,
      ),
    );
  }
}
