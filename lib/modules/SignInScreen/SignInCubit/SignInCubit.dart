import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/models/profiledata.dart';
import 'package:target_manangment/modules/SignInScreen/SignInCubit/SignInStates.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignIninialstate());

  static SignInCubit get(context) => BlocProvider.of(context);

  void postRgister({
    required String email,
    required String password,
    required String phone,
    required String username,
  }) {
    emit(SignInLoadData());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      try {
        setUserData(
            email: email,
            userId: value.user!.uid,
            phone: phone,
            username: username);
      } catch (error) {
        print(error.toString());
      }
      print(value.user?.email);
    }).catchError((error) {
      print(error.toString());
      emit(SignInError());
    });
  }

  void setUserData({
    required String email,
    required String userId,
    required String phone,
    required String username,
  }) {
    ProfileData profileData = ProfileData(
      userId: userId,
      email: email,
      phone: phone,
      username: username,
      image:
          'https://scontent.faly2-2.fna.fbcdn.net/v/t39.30808-6/420444035_3222448044566552_5734659718070535202_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=bJwQXTIdqxIQ7kNvgG_FGa9&_nc_ht=scontent.faly2-2.fna&oh=00_AYDRTu2h3Pn8uChIaTCBATQ55sPXedv0lnUFWyub3kZVvw&oe=669D6B28',
      cover:
          'https://scontent.faly2-2.fna.fbcdn.net/v/t39.30808-6/240078414_1036938353778426_6951240705318728582_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=1QX8CG_d_aIQ7kNvgFDlPAZ&_nc_ht=scontent.faly2-2.fna&oh=00_AYD63rf7G_8wyeFta3n7IrnsiDpcUk_1w3BPNP4jUlCnWw&oe=669D5423',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(profileData.toMap())
        .then((value) {
      print('done');
      emit(SignInSucessful());
    }).catchError((error) {
      emit(SetDataError());
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
