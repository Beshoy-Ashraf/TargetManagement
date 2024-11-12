import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    double DevicesKpi = initAch.devicesper;
    double Home4GKpi = initAch.home4gper;
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
    DSLper = (DSL != 0)
        ? ((totalDsl * 100 / DSL).toInt())
        : (totalDsl * 100).toInt();
    DSLKpi = (GA != 0) ? (DSLper * DSLKpi / 100).toInt() : 0;
    Devicesper = (Devices != 0) ? ((totalDevices * 100 / Devices).toInt()) : 0;
    DevicesKpi = (Devicesper * DevicesKpi / 100).toInt() > 5
        ? 5
        : (Devicesper * DevicesKpi / 100);
    Home4Gper = (Home4G != 0) ? ((totalHome4G * 100 / Home4G).toInt()) : 0;
    Home4GKpi = (Home4Gper * Home4GKpi / 100).toDouble();
    double totalKpi = pointKpi + OCKpi + DSLKpi + DevicesKpi + Home4GKpi;
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
                    // Card 1: Points
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Points',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[800],
                                ),
                              ),
                              SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: pointper / 100,
                                backgroundColor: Colors.orange[100],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.orange),
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Text('${(pointper).toString()}%',
                                      style: TextStyle(fontSize: 16))),
                              Text(
                                'Remaining: ${((100 - pointper)).toInt()}%',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text('Remaining: ${(point - totalPoints)} points',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('Achieved: ${(totalPoints)} points',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('KPI growth: ${(pointKpi)}%',
                                  style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Card 2: Lines
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lines',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[800],
                                ),
                              ),
                              SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: GAper / 100,
                                backgroundColor: Colors.orange[100],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.orange),
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Text('${(GAper).toString()}%',
                                      style: TextStyle(fontSize: 16))),
                              Text(
                                'Remaining: ${((100 - GAper)).toInt()}%',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text('Remaining: ${(GA - totalGA)} lines',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('Achieved: ${(totalGA)} lines',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('KPI growth: ${(GAKpi)}%',
                                  style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Card 3: Orange Cash
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Orange Cash',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[800],
                                ),
                              ),
                              SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: OCper / 100,
                                backgroundColor: Colors.orange[100],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.orange),
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Text('${(OCper).toString()}%',
                                      style: TextStyle(fontSize: 16))),
                              Text(
                                'Remaining: ${((100 - OCper)).toInt()}%',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text('Remaining: ${(OC - totalOC)} wallets',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('Achieved: ${(totalOC)} wallets',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('KPI growth: ${(OCKpi)}%',
                                  style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Card 4: Home 4G
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Home 4G',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[800],
                                ),
                              ),
                              SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: Home4Gper / 100,
                                backgroundColor: Colors.orange[100],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.orange),
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Text('${(Home4Gper).toString()}%',
                                      style: TextStyle(fontSize: 16))),
                              Text(
                                'Remaining: ${((100 - Home4Gper)).toInt()}%',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                  'Remaining: ${(Home4G - totalHome4G)} Home 4G',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('Achieved: ${(totalHome4G)} Home 4G',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('KPI growth: ${(Home4GKpi)}%',
                                  style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Card 5: DSL
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DSL',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[800],
                                ),
                              ),
                              SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: DSLper / 100,
                                backgroundColor: Colors.orange[100],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.orange),
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Text('${(DSLper).toString()}%',
                                      style: TextStyle(fontSize: 16))),
                              Text(
                                'Remaining: ${((100 - DSLper)).toInt()}%',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text('Remaining: ${(DSL - totalDsl)} DSL lines',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('Achieved: ${(totalDsl)} DSL lines',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('KPI growth: ${(DSLKpi)}%',
                                  style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Card 6: Devices
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Devices',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[800],
                                ),
                              ),
                              SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: Devicesper / 100,
                                backgroundColor: Colors.orange[100],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.orange),
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Text('${(Devicesper).toString()}%',
                                      style: TextStyle(fontSize: 16))),
                              Text(
                                'Remaining: ${((100 - Devicesper)).toInt()}%',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                  'Remaining: ${(Devices - totalDevices)} devices',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('Achieved: ${(totalDevices)} devices',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('KPI growth: ${(DevicesKpi)}%',
                                  style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Card 7: Total KPI
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total KPI',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[800],
                                ),
                              ),
                              SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: totalKpi / 100,
                                backgroundColor: Colors.orange[100],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.orange),
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: Text('${(totalKpi).toString()}%',
                                      style: TextStyle(fontSize: 16))),
                              Text(
                                'Remaining: ${((100 - totalKpi)).toInt()}%',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text('Achieved: ${(totalKpi)}%',
                                  style: TextStyle(color: Colors.grey[600])),
                              Text('Target growth: ${(totalKpi)}%',
                                  style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ),
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
