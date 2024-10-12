import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/HomeLayout.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/shared/components/components.dart';

class InitialTarget extends StatelessWidget {
  const InitialTarget({super.key});

  @override
  Widget build(BuildContext context) {
    var Point = TextEditingController();
    var PointPercent = TextEditingController();
    var GA = TextEditingController();
    var GAPercent = TextEditingController();
    var DSL = TextEditingController();
    var DSLPercent = TextEditingController();
    var HOME4G = TextEditingController();
    var Home4GPercent = TextEditingController();
    var OC = TextEditingController();
    var OCPercent = TextEditingController();
    var Devices = TextEditingController();
    var DevicesPercent = TextEditingController();
    var FormKey = GlobalKey<FormState>();
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: defualtTextinput(
                              controller: Point,
                              Type: TextInputType.number,
                              label: 'Point',
                              validate: (value) => value!.isEmpty
                                  ? 'Point quantity is required'
                                  : null,
                              password: false),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: defualtTextinput(
                              controller: PointPercent,
                              Type: TextInputType.number,
                              label: 'Point',
                              suffixIcon: Icons.percent,
                              validate: (value) => value!.isEmpty
                                  ? 'Point percent is required'
                                  : null,
                              password: false),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defualtTextinput(
                              controller: GA,
                              Type: TextInputType.number,
                              label: 'GA',
                              validate: (value) => value!.isEmpty
                                  ? 'GA quantity is required'
                                  : null,
                              password: false),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: defualtTextinput(
                              controller: GAPercent,
                              Type: TextInputType.number,
                              label: 'GA',
                              suffixIcon: Icons.percent,
                              validate: (value) => value!.isEmpty
                                  ? 'GA percent is required'
                                  : null,
                              password: false),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defualtTextinput(
                              controller: DSL,
                              Type: TextInputType.number,
                              label: 'DSL',
                              validate: (value) => value!.isEmpty
                                  ? 'DSL quantity is required'
                                  : null,
                              password: false),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: defualtTextinput(
                              controller: DSLPercent,
                              Type: TextInputType.number,
                              label: 'DSL',
                              suffixIcon: Icons.percent,
                              validate: (value) => value!.isEmpty
                                  ? 'DSL percent is required'
                                  : null,
                              password: false),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defualtTextinput(
                              controller: HOME4G,
                              Type: TextInputType.number,
                              label: 'HOME 4G',
                              validate: (value) => value!.isEmpty
                                  ? 'Home 4G quantity is required'
                                  : null,
                              password: false),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: defualtTextinput(
                              controller: Home4GPercent,
                              Type: TextInputType.number,
                              label: 'Home 4G',
                              suffixIcon: Icons.percent,
                              validate: (value) => value!.isEmpty
                                  ? 'Home 4G percent is required'
                                  : null,
                              password: false),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defualtTextinput(
                              controller: OC,
                              Type: TextInputType.number,
                              label: 'OC',
                              validate: (value) => value!.isEmpty
                                  ? 'OC quantity is required'
                                  : null,
                              password: false),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: defualtTextinput(
                              controller: OCPercent,
                              Type: TextInputType.number,
                              label: 'OC',
                              suffixIcon: Icons.percent,
                              validate: (value) => value!.isEmpty
                                  ? 'OC percent is required'
                                  : null,
                              password: false),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defualtTextinput(
                              controller: Devices,
                              Type: TextInputType.number,
                              label: 'Devices',
                              validate: (value) => value.isEmpty
                                  ? 'Devices quantity is required'
                                  : null,
                              password: false),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: defualtTextinput(
                              controller: DevicesPercent,
                              Type: TextInputType.number,
                              label: 'Devices',
                              suffixIcon: Icons.percent,
                              validate: (value) => value!.isEmpty
                                  ? 'devices percent is required'
                                  : null,
                              password: false),
                        )
                      ],
                    ),
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
                        onPressed: () {
                          if (FormKey.currentState!.validate()) {
                            Appcubit.get(context).setInatioalTarget(
                                point: int.parse(Point.text),
                                GA: int.parse(GA.text),
                                oc: int.parse(OC.text),
                                dsl: int.parse(DSL.text),
                                home4g: int.parse(HOME4G.text),
                                devices: int.parse(Devices.text),
                                pointper: int.parse(PointPercent.text),
                                GAper: int.parse(GAPercent.text),
                                ocper: int.parse(OCPercent.text),
                                dslper: int.parse(DSLPercent.text),
                                home4gper: int.parse(Home4GPercent.text),
                                devicesper: int.parse(DevicesPercent.text));
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
