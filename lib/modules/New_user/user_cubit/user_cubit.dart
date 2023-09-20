import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/core/cache_helper.dart';
import 'package:taskapp/core/constants.dart';
import 'package:taskapp/core/end_points.dart';
import 'package:taskapp/modules/New_user/user_model.dart';
import 'package:taskapp/modules/login_screen/Login_cubit/login_state.dart';
import 'package:taskapp/modules/login_screen/login_model/login_model.dart';
import 'package:taskapp/modules/new_department/department_model/department_model.dart';

import '../../../core/dio_helper.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit() : super(UserInitialState());

  static UserCubit get(context)=>BlocProvider.of(context);

  UserModel? userModel;
  void createNewUser({
  required String name,
  required String email,
  required String phone,
  required String password,
}){
    emit(NewUserLoadingState());
    DioHelper.postData(url: user, data: {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'password' : password,
      'user_type' : '1',
    },
      token: token
    ).then((value){
      userModel = UserModel.fromJson(value.data);
      print(userModel!.message);
      emit(NewUserSuccessState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(NewUserErrorState(error.toString()));
    });
  }
}