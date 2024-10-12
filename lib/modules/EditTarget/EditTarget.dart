import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/models/datamodel.dart';
import 'package:target_manangment/modules/EditTarget/EditDay.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:target_manangment/shared/constant/constant.dart';

class EditTarget extends StatelessWidget {
  const EditTarget({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat(' - MM - yyyy');
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Day(
                          context: context,
                          date: formatter.format(now),
                          index: index + 1);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 30,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget Day({context, required String date, required int index}) {
    return InkWell(
      onTap: () async {
        // bool find = false;
        // List<Map<String, dynamic>> targets =
        //     await Appcubit.get(context).retrieveData();
        // targets.forEach((target) {
        //   if (target['day'] == '$index$date') {
        //     navigateTo(
        //         context,
        //         EditDay(
        //           target: Target.fromMap(target),
        //         ));
        //     find = !find;
        //   }
        // });

        try {
          await Appcubit.get(context)
              .getTargetDataForDay(userId, '$index$date');
          print('$index$date');
          if ('$index$date' == Appcubit.get(context).target!.day) {
            navigateTo(
                context,
                EditDay(
                    points_d: Appcubit.get(context).target!.point,
                    day: Appcubit.get(context).target!.day,
                    GA_d: Appcubit.get(context).target!.GA,
                    OC_d: Appcubit.get(context).target!.orangeCash,
                    DSL_d: Appcubit.get(context).target!.adsl,
                    HOME4G_d: Appcubit.get(context).target!.home4g,
                    Device_d: Appcubit.get(context).target!.devices));
          } else {
            showtoast(msg: 'day not found', state: ToastStates.ERROR);
          }
        } catch (error) {
          showtoast(msg: 'day not found', state: ToastStates.ERROR);
        }
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
                            '$index$date',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
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
    );
  }
}
