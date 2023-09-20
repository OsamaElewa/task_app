import 'package:taskapp/modules/New_user/user_model.dart';
import 'package:taskapp/modules/login_screen/login_model/login_model.dart';
import 'package:taskapp/modules/new_department/department_model/department_model.dart';

abstract class UserState{}

class UserInitialState extends UserState{}


class NewUserLoadingState extends UserState{}

class NewUserSuccessState extends UserState{
  final UserModel userModel;
  NewUserSuccessState(this.userModel);

}

class NewUserErrorState extends UserState {
  final String error;
  NewUserErrorState(this.error);
}
