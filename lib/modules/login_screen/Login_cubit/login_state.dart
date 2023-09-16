import 'package:taskapp/modules/login_screen/login_model/login_model.dart';

abstract class TaskLoginState{}

class TaskLoginInitialState extends TaskLoginState{}

class TaskLoginLoadingState extends TaskLoginState{}

class TaskLoginSuccessState extends TaskLoginState{
  final LoginModel loginModel;
  TaskLoginSuccessState(this.loginModel);

}

class TaskLoginErrorState extends TaskLoginState {
  final String error;
  TaskLoginErrorState(this.error);
}
