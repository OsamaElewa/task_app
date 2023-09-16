import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/core/end_points.dart';
import 'package:taskapp/modules/login_screen/Login_cubit/login_state.dart';
import 'package:taskapp/modules/login_screen/login_model/login_model.dart';

import '../../../core/dio_helper.dart';

class LoginCubit extends Cubit<TaskLoginState>{
  LoginCubit() : super(TaskLoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);


  LoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }){
    emit(TaskLoginLoadingState());
    ///ToDo: make login function
    DioHelper.postData(url: LOGIN, data:{
      'email' : email,
      'password' : password,
    },).then((value){
      print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      emit(TaskLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(TaskLoginErrorState(error.toString()));
    });
  }
}