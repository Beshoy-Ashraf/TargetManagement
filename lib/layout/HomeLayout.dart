import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/modules/Achievement/Achievement.dart';
import 'package:target_manangment/modules/DailyAtchievement/dailyAchievement.dart';
import 'package:target_manangment/modules/KPI&Award/KPI&Award.dart';
import 'package:target_manangment/modules/Setting/Setting.dart';
import 'package:target_manangment/modules/knowledge/knowledge.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:airtable_icons/airtable_icons.dart';
import 'package:target_manangment/shared/constant/constant.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var FromCubit = Appcubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await FromCubit.getInitTarget(userId);
                      await FromCubit.getTotalachievement(userId);
                      navigateTo(
                          context,
                          Achievement(
                            initAch: FromCubit.InitTarget!,
                            t: FromCubit.total!,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 150,
                        child: Card(
                          color: Theme.of(context).cardTheme.color,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.auto_graph,
                                    size: 50,
                                    color: Colors.orange[900],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Achievement',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, knowledge());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 150,
                        child: Card(
                          color: Theme.of(context).cardTheme.color,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AirtableIcon(
                                    AirtableIcons.lookup,
                                    size: 50,
                                    color: Colors.orange[900],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Knowledge',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, KPIAndAward());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 150,
                        child: Card(
                          color: Theme.of(context).cardTheme.color,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AirtableIcon(
                                    AirtableIcons.gift,
                                    size: 50,
                                    color: Colors.orange[900],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'KPI & Award',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, DailyAtchievement());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 150,
                        child: Card(
                          color: Theme.of(context).cardTheme.color,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit_note,
                                    size: 50,
                                    color: Colors.orange[900],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'daily atchivement',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateTo(context, Setting());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 150,
                        child: Card(
                          color: Theme.of(context).cardTheme.color,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AirtableIcon(
                                    AirtableIcons.settings,
                                    size: 50,
                                    color: Colors.orange[900],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Settings',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // body: FromCubit.body[FromCubit.CurrentIndex],
          // bottomNavigationBar: BottomNavigationBar(
          //   selectedItemColor: Colors.orange[900],
          //   elevation: 5.0,
          //   currentIndex: FromCubit.CurrentIndex,
          //   onTap: (value) {
          //     FromCubit.IndexChange(value);
          //   },
          //   type: BottomNavigationBarType.fixed,
          //   items: [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.auto_graph),
          //       label: 'Achievement',
          //     ),
          //     BottomNavigationBarItem(
          //         icon: AirtableIcon(AirtableIcons.text), label: 'Knowledge'),
          //     BottomNavigationBarItem(
          //         icon: AirtableIcon(AirtableIcons.gift), label: 'KPIAndAward'),
          //     BottomNavigationBarItem(
          //         icon: AirtableIcon(AirtableIcons.settings),
          //         label: 'Settings'),
          //   ],
          // ),
        );
      },
    );
  }
}
