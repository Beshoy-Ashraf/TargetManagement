import 'package:flutter/material.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/modules/Achievement/Achievement.dart';
import 'package:target_manangment/modules/DailyAtchievement/dailyAchievement.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:target_manangment/shared/constant/constant.dart';

class Targetpage extends StatelessWidget {
  const Targetpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
            child: InkWell(
              onTap: () {
                navigateTo(context, DailyAtchievement());
              },
              child: Card(
                color: Colors.white,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Daily Achievement',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: c,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(Icons.forward_outlined)
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () async {
                try {
                  print(userId);
                  Appcubit.get(context).clear();
                  await Appcubit.get(context).getInitTarget(userId);
                  await Appcubit.get(context).getTotalachievement(userId);

                  navigateTo(
                      context,
                      Achievement(
                        initAch: Appcubit.get(context).InitTarget!,
                        t: Appcubit.get(context).total!,
                      ));
                } catch (e) {
                  showtoast(
                      msg:
                          'set initial target first,second enter your daily achievement',
                      state: ToastStates.ERROR);
                }
              },
              child: Card(
                color: Colors.white,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Achievement',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: c,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(Icons.forward_outlined)
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
