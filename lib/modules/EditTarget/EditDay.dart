import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
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
                      // Input fields
                      _buildInputField(Point, 'Entered points: $points_d',
                          'points is required'),
                      SizedBox(height: 20),
                      _buildInputField(
                          GA, 'Entered GA: $GA_d', 'GA quantity is required'),
                      SizedBox(height: 20),
                      _buildInputField(OC, 'Entered wallets: $OC_d',
                          'OC quantity is required'),
                      SizedBox(height: 20),
                      _buildInputField(DSL, 'Entered DSL: $DSL_d',
                          'DSL quantity is required'),
                      SizedBox(height: 20),
                      _buildInputField(HOME4G, 'Entered Home 4G: $HOME4G_d',
                          'Home 4G quantity is required'),
                      SizedBox(height: 20),
                      _buildInputField(Devices, 'Entered Devices: $Device_d',
                          'Devices quantity is required'),
                      SizedBox(height: 30),

                      // Submit button
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          border: Border.all(color: Colors.orange, width: 1),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (FormKey.currentState!.validate()) {
                              Appcubit.get(context).UpdateUserData(
                                day: day,
                                point: int.parse(Point.text),
                                GA: int.parse(GA.text),
                                oc: int.parse(OC.text),
                                dsl: int.parse(DSL.text),
                                home4g: int.parse(HOME4G.text),
                                devices: int.parse(Devices.text),
                              );
                              Appcubit.get(context).calculateTotalAchieve();
                              navigateAndFinish(context, EditTarget());
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

// Custom function to build input fields
        });
  }

  Widget _buildInputField(
      TextEditingController controller, String label, String errorText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? errorText : null,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          labelStyle: TextStyle(color: Colors.orange),
        ),
      ),
    );
  }
}
