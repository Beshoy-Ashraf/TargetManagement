import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:target_manangment/layout/HomeLayout.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/shared/components/components.dart';

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
                    TextFormField(
                      controller: Point,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Point quantity is required' : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Total point',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: GA,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'GA quantity is required' : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Total GA',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: OC,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'OC quantity is required' : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Total Orange Cash',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: DSL,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'DSL quantity is required' : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Total DSL',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: HOME4G,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty
                          ? 'Home 4G quantity is required'
                          : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Total Home 4G',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: Devices,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty
                          ? 'Devices quantity is required'
                          : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Total Devices',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange[400]!, Colors.yellow[700]!],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          if (FormKey.currentState!.validate()) {
                            print(formatter.format(now));
                            FromCubit.setUserData(
                              day: formatter.format(now),
                              point: int.parse(Point.text),
                              GA: int.parse(GA.text),
                              oc: int.parse(OC.text),
                              dsl: int.parse(DSL.text),
                              home4g: int.parse(HOME4G.text),
                              devices: int.parse(Devices.text),
                            );
                            Appcubit.get(context).calculateTotalAchieve();
                            navigateAndFinish(context, HomeLayout());
                          } else {
                            print('Not Valid');
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
