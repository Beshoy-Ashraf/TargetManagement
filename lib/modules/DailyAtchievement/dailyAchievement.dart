import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:target_manangment/layout/HomeLayout.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/models/datamodel.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:target_manangment/shared/constant/constant.dart';

class DailyAtchievement extends StatelessWidget {
  const DailyAtchievement({super.key});

  @override
  Widget build(BuildContext context) {
    var Point = TextEditingController();
    var GA = TextEditingController();
    var DSL = TextEditingController();
    var HOME4G = TextEditingController();
    var OC = TextEditingController();
    var Devices = TextEditingController();
    var FormKey = GlobalKey<FormState>();
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('d - MM - yyyy');
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var FromCubit = Appcubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    defualtTextinput(
                        controller: Point,
                        Type: TextInputType.number,
                        label: 'Total point',
                        validate: (value) =>
                            value!.isEmpty ? 'OC quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: GA,
                        Type: TextInputType.number,
                        label: 'Total GA',
                        validate: (value) =>
                            value!.isEmpty ? 'OC quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: OC,
                        Type: TextInputType.number,
                        label: 'Total Orange Cash',
                        validate: (value) =>
                            value!.isEmpty ? 'OC quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: DSL,
                        Type: TextInputType.number,
                        label: 'Total DSL',
                        validate: (value) =>
                            value!.isEmpty ? 'OC quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: HOME4G,
                        Type: TextInputType.number,
                        label: 'Total  Home 4G',
                        validate: (value) =>
                            value!.isEmpty ? 'OC quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: Devices,
                        Type: TextInputType.number,
                        label: 'Total Devices',
                        validate: (value) =>
                            value!.isEmpty ? 'OC quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.orange[200],
                          border: Border.all(color: Colors.orange, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () async {
                          if (FormKey.currentState!.validate()) {
                            // FromCubit.insertData(
                            //     formatter.format(now),
                            //     int.parse(Point.text),
                            //     int.parse(GA.text),
                            //     int.parse(OC.text),
                            //     int.parse(DSL.text),
                            //     int.parse(HOME4G.text),
                            //     int.parse(Devices.text));
                            print(formatter.format(now));
                            FromCubit.setUserData(
                                day: formatter.format(now),
                                point: int.parse(Point.text),
                                GA: int.parse(GA.text),
                                oc: int.parse(OC.text),
                                dsl: int.parse(DSL.text),
                                home4g: int.parse(HOME4G.text),
                                devices: int.parse(Devices.text));
                            navigateAndFinish(context, HomeLayout());
                          } else {
                            print('Not Valid');
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
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
