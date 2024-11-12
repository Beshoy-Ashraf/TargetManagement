import 'package:flutter/material.dart';
import 'package:target_manangment/modules/EditTarget/EditTarget.dart';
import 'package:target_manangment/modules/InitialTarget/InitialTarger.dart';
import 'package:target_manangment/modules/KpiAndAword/KpiAndAword.dart';
import 'package:target_manangment/modules/LogInScreen/LogInScreen.dart';
import 'package:target_manangment/modules/newInformation/newInformation.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:target_manangment/shared/constant/constant.dart';
import 'package:target_manangment/shared/network/local/shared_helper.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    bool isadmin = CashHelper.getData(key: 'isAdmin');
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            CashHelper.removeData(key: 'userId');
            CashHelper.removeData(key: 'isAdmin');
            navigateTo(context, Login());
          },
          icon: Icon(Icons.logout_outlined),
        )
      ]),
      body: Padding(
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
                ],
              )
          ],
        ),
      ),
    );
  }
}
