import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/modules/Achievement/Achievement.dart';
import 'package:target_manangment/modules/DailyAtchievement/dailyAchievement.dart';
import 'package:target_manangment/modules/LogInScreen/LogInScreen.dart';
import 'package:target_manangment/modules/quiz/quiz.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:target_manangment/modules/Setting/Setting.dart';
import 'package:target_manangment/shared/constant/constant.dart';
import 'package:target_manangment/shared/network/local/shared_helper.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Achievement',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          unselectedItemColor: Colors.white.withOpacity(0.5),
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var fromCubit = Appcubit.get(context);
        return Scaffold(
          body: fromCubit.screens[fromCubit.currentIndex],
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: fromCubit.currentIndex,
            onTap: (index) {
              fromCubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
