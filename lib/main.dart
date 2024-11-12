import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:target_manangment/layout/HomeLayout.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/modules/LogInScreen/LogInScreen.dart';
import 'package:target_manangment/shared/constant/constant.dart';
import 'package:target_manangment/shared/cubit/appcubit.dart';
import 'package:target_manangment/shared/cubit/appcubitstate.dart';
import 'package:target_manangment/shared/network/local/shared_helper.dart';
import 'package:target_manangment/shared/style/thems.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyATxpOoET8QlWWYwfNhNzIfbtP_uOYPRc4',
          appId: '1:583984292974:android:566124408e448c56b1f27f',
          messagingSenderId: '583984292974',
          projectId: 'targetmanagement-8103c',
          storageBucket: 'targetmanagement-8103c.appspot.com'));
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await CashHelper.init();
  bool? isDark = CashHelper.getData(key: 'isDark');
  userId = CashHelper.getData(key: 'userId');

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              appcubit()..changeAppMode(fromsherd: isDark),
        ),
        BlocProvider(
            create: (BuildContext context) => Appcubit()
              ..clear()
              ..calculateTotalAchieve()),
      ],
      child: BlocConsumer<appcubit, appcubistate>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en', ''), // English
                Locale('ar', ''), // Arabic
              ],
              home: (userId)?.isNotEmpty ?? false ? HomeLayout() : Login(),
            ),
          );
        },
      ),
    );
  }
}
