abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginloadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  String error;
  LoginErrorState(this.error);
}

class ChangePasswordState extends LoginState {}
