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
    double percent = value / 100;
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return itemBild(
                          context: context,
                          total: t,
                          init: initAch,
                          title: titels[index],
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: titels.length,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> titels = [
    'Point',
    'GA',
    'DSL',
    'HOME 4G',
    'Devices',
    'Orange Cash',
  ];

  Widget itemBild({
    required BuildContext context,
    required String title,
    required int index,
    required Total total,
    required initialTarget init,
  }) {
    return Card(
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
                      title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: 200,
              ),
              Center(child: Text('${(200 * 100).toString()}%')),
              Text('remain : ${((1 - 200) * 100).toInt()} % : '),
              Text(init.GA.toString())
            ],
          ),
        ),
      ),
    );
  }
}
