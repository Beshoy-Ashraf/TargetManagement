import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/shared/cubit/appcubitstate.dart';
import 'package:target_manangment/shared/network/local/shared_helper.dart';

class appcubit extends Cubit<appcubistate> {
  appcubit() : super(appcubitinitial());

  static appcubit get(context) => BlocProvider.of(context);
  bool isdark = false;
  void changeAppMode({bool? fromsherd}) {
    if (fromsherd != null) {
      isdark = fromsherd;
      emit(appchangemode());
    } else {
      isdark = !isdark;
      CashHelper.saveData(key: 'isDark', value: isdark).then((value) {
        emit(appchangemode());
      });
    }
  }
}
