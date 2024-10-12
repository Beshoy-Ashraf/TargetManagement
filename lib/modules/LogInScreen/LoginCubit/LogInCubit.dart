import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/HomeLayout.dart';
import 'package:target_manangment/modules/LogInScreen/LoginCubit/LogInStates.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:target_manangment/shared/network/local/shared_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void postLogin({required String email, required String password, context}) {
    emit(LoginloadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CashHelper.saveData(key: 'userId', value: value.user!.uid);
      navigateAndFinish(context, HomeLayout());
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData Suffix = Icons.remove_red_eye;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    Suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off_outlined;
    emit(ChangePasswordState());
  }
}
