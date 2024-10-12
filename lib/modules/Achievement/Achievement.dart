import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/models/initialModel.dart';
import 'package:target_manangment/models/total.dart';

class Achievement extends StatelessWidget {
  final Total t;
  final initialTarget initAch;
  Achievement({super.key, required this.t, required this.initAch});

  @override
  Widget build(BuildContext context) {
    int value = 70;
    int totalPoints = t.point;
    int totalGA = t.GA;
    int totalOC = t.orangeCash;
    int totalHome4G = t.home4g;
    int totalDevices = t.devices;
    int totalDsl = t.adsl;
    int pointKpi = initAch.pointper;
    int OCKpi = initAch.orangeCashper;
    int DSLKpi = initAch.adslper;
    int GAKpi = initAch.GAper;
    int DevicesKpi = initAch.devicesper;
    int Home4GKpi = initAch.home4gper;
    int point = initAch.point;
    int GA = initAch.GA;
    int OC = initAch.orangeCash;
    int DSL = initAch.adsl;
    int Home4G = initAch.home4g;
    int Devices = initAch.devices;
    int pointper = 0;
    int GAper = 0;
    int OCper = 0;
    int DSLper = 0;
    int Home4Gper = 0;
    int Devicesper = 0;
    pointper = (point != 0) ? ((totalPoints * 100 / point).toInt()) : 0;
    pointKpi = (pointper * pointKpi / 100).toInt();
    GAper = (GA != 0) ? ((totalGA * 100 / GA).toInt()) : 0;
    OCper = (OC != 0) ? ((totalOC * 100 / OC).toInt()) : 0;
    OCKpi = (OCper * OCKpi / 100).toInt();
    DSLper = (DSL != 0) ? ((totalDsl * 100 / DSL).toInt()) : 0;
    DSLKpi = (DSLper * DSLKpi / 100).toInt();
    Devicesper = (Devices != 0) ? ((totalDevices * 100 / Devices).toInt()) : 0;
    DevicesKpi = (Devicesper * DevicesKpi / 100).toInt();
    Home4Gper = (Home4G != 0) ? ((totalHome4G * 100 / Home4G).toInt()) : 0;
    Home4GKpi = (Home4Gper * Home4GKpi / 100).toInt();
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Center(
                child: Column(
                  children: [
                    Card(
                      color: Theme.of(context).cardTheme.color,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'point',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              LinearProgressIndicator(
                                value: pointper / 100,
                              ),
                              Center(child: Text('${(pointper).toString()}%')),
                              Text('remain : ${((100 - pointper)).toInt()} % '),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  'remain : ${(point - totalPoints)} points  '),
                              SizedBox(
                                width: 5,
                              ),
                              Text('achieve : ${(totalPoints)} points'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).cardTheme.color,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'lines',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              LinearProgressIndicator(
                                value: GAper / 100,
                              ),
                              Center(child: Text('${(GAper).toString()}%')),
                              Text('remain : ${((100 - GAper)).toInt()} % '),
                              SizedBox(
                                width: 5,
                              ),
                              Text('remain : ${(GA - totalGA)} lines  '),
                              SizedBox(
                                width: 5,
                              ),
                              Text('achieve : ${(totalGA)} liens'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).cardTheme.color,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'Orange Cash',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              LinearProgressIndicator(
                                value: OCper / 100,
                              ),
                              Center(child: Text('${(OCper).toString()}%')),
                              Text('remain : ${((100 - OCper)).toInt()} % '),
                              SizedBox(
                                width: 5,
                              ),
                              Text('remain : ${(OC - totalOC)} walets  '),
                              SizedBox(
                                width: 5,
                              ),
                              Text('achieve : ${(totalOC)} walets'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).cardTheme.color,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'Home 4G',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              LinearProgressIndicator(
                                value: Home4Gper / 100,
                              ),
                              Center(child: Text('${(Home4Gper).toString()}%')),
                              Text(
                                  'remain : ${((100 - Home4Gper)).toInt()} % '),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  'remain : ${(Home4G - totalHome4G)} Home 4G  '),
                              SizedBox(
                                width: 5,
                              ),
                              Text('achieve : ${(totalHome4G)} Home 4G'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).cardTheme.color,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'DSL',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              LinearProgressIndicator(
                                value: DSLper / 100,
                              ),
                              Center(child: Text('${(DSLper).toString()}%')),
                              Text('remain : ${((100 - DSLper)).toInt()} % '),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  'remain : ${((DSL - totalDsl) < 0 ? 0 : (DSL - totalDsl))} DSL  '),
                              SizedBox(
                                width: 5,
                              ),
                              Text('achieve : ${(totalDsl)} DSL'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Theme.of(context).cardTheme.color,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'Devices',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              LinearProgressIndicator(
                                value: Devicesper / 100,
                              ),
                              Center(
                                  child: Text('${(Devicesper).toString()}%')),
                              Text(
                                  'remain : ${((100 - Devicesper)).toInt()} % '),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  'remain : ${(Devices - totalDevices)} Devices  '),
                              SizedBox(
                                width: 5,
                              ),
                              Text('achieve : ${(totalDevices)} Devices'),
                            ],
                          ),
                        ),
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
        );
      },
    );
  }
}
