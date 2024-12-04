import 'package:flutter/material.dart';
import 'package:target_manangment/modules/EditTarget/EditTarget.dart';
import 'package:target_manangment/modules/InitialTarget/InitialTarger.dart';
import 'package:target_manangment/modules/KpiAndAword/KpiAndAword.dart';
import 'package:target_manangment/modules/LogInScreen/LogInScreen.dart';
import 'package:target_manangment/modules/instructions/instructions.dart';
import 'package:target_manangment/modules/newInformation/newInformation.dart';
import 'package:target_manangment/modules/offers/addoffer.dart';
import 'package:target_manangment/modules/offers/deleteoffers.dart';
import 'package:target_manangment/modules/quiz/setQuiz.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:target_manangment/shared/constant/constant.dart';
import 'package:target_manangment/shared/network/local/shared_helper.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    bool isadmin = CashHelper.getData(key: 'isAdmin');
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  navigateTo(context, InitialTarget());
                },
                child: Card(
                  color: Theme.of(context).cardTheme.color,
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
                                      'Initial Target',
                                      style: TextStyle(
                                          color: c,
                                          fontSize: 15,
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
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  navigateTo(context, EditTarget());
                },
                child: Card(
                  color: Theme.of(context).cardTheme.color,
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
                                      'edit',
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
              SizedBox(
                height: 10,
              ),
              if (isadmin)
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, NewInformation());
                      },
                      child: Card(
                        color: Theme.of(context).cardTheme.color,
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
                                            'Add new information',
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
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, KPI());
                      },
                      child: Card(
                        color: Theme.of(context).cardTheme.color,
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
                                            'KPIs & Awards',
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
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, QuizSetupScreen());
                      },
                      child: Card(
                        color: Theme.of(context).cardTheme.color,
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
                                            'Set Quiz Questions',
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
                    InkWell(
                      onTap: () {
                        navigateTo(context, instructions());
                      },
                      child: Card(
                        color: Theme.of(context).cardTheme.color,
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
                                            'Set instructions',
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
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, AddOfferScreen());
                      },
                      child: Card(
                        color: Theme.of(context).cardTheme.color,
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
                                            'Set offers',
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
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, DeleteOfferScreen());
                      },
                      child: Card(
                        color: Theme.of(context).cardTheme.color,
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
                                            'delete offer',
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () {
                    CashHelper.removeData(key: 'token').then((value) {});
                    CashHelper.removeData(key: 'isadmin').then((value) {});
                    CashHelper.removeData(key: 'userId').then((value) {});
                    userId = '';
                    isadmin = false;
                    token = '';
                    navigateAndFinish(context, Login());
                  },
                  child: Text(
                    'Sign out',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
