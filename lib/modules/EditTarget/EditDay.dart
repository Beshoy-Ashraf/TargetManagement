import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/models/datamodel.dart';
import 'package:target_manangment/modules/EditTarget/EditTarget.dart';
import 'package:target_manangment/shared/components/components.dart';

class EditDay extends StatelessWidget {
  final String day;
  final int points_d;
  final int GA_d;
  final int OC_d;
  final int DSL_d;
  final int Device_d;
  final int HOME4G_d;
  EditDay({
    Key? key,
    required this.points_d,
    required this.day,
    required this.GA_d,
    required this.OC_d,
    required this.DSL_d,
    required this.HOME4G_d,
    required this.Device_d,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Point = TextEditingController();
    var GA = TextEditingController();
    var DSL = TextEditingController();
    var HOME4G = TextEditingController();
    var OC = TextEditingController();
    var Devices = TextEditingController();
    var FormKey = GlobalKey<FormState>();

    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                        label: 'Entered points : $points_d',
                        validate: (value) =>
                            value!.isEmpty ? 'points is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: GA,
                        Type: TextInputType.number,
                        label: 'Entered GA :$GA_d',
                        validate: (value) =>
                            value!.isEmpty ? 'GA quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: OC,
                        Type: TextInputType.number,
                        label: 'Entered wallets : $OC_d',
                        validate: (value) =>
                            value!.isEmpty ? 'OC quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: DSL,
                        Type: TextInputType.number,
                        label: 'Entered DSL : $DSL_d',
                        validate: (value) =>
                            value!.isEmpty ? 'Dsl quantity is required' : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: HOME4G,
                        Type: TextInputType.number,
                        label: 'Entered Home 4G : $HOME4G_d',
                        validate: (value) => value!.isEmpty
                            ? 'Home 4G quantity is required'
                            : null,
                        password: false),
                    SizedBox(
                      height: 20,
                    ),
                    defualtTextinput(
                        controller: Devices,
                        Type: TextInputType.number,
                        label: 'Entered Devices : $Device_d',
                        validate: (value) => value!.isEmpty
                            ? 'Devices quantity is required'
                            : null,
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
                        onPressed: () {
                          if (FormKey.currentState!.validate()) {
                            // Appcubit.get(context).updateData(
                            //     target.day,
                            //     int.parse(Point.text),
                            //     int.parse(GA.text),
                            //     int.parse(OC.text),
                            //     int.parse(DSL.text),
                            //     int.parse(HOME4G.text),
                            //     int.parse(Devices.text));
                            Appcubit.get(context).UpdateUserData(
                                day: day,
                                point: int.parse(Point.text),
                                GA: int.parse(GA.text),
                                oc: int.parse(OC.text),
                                dsl: int.parse(DSL.text),
                                home4g: int.parse(HOME4G.text),
                                devices: int.parse(Devices.text));
                            navigateAndFinish(context, EditTarget());
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
