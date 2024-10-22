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
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align items to the left
                  children: [
                    _buildRowInput(
                        Point,
                        PointPercent,
                        'Points',
                        'Point quantity is required',
                        'Point percent is required'),
                    SizedBox(height: 20),
                    _buildRowInput(GA, GAPercent, 'GA',
                        'GA quantity is required', 'GA percent is required'),
                    SizedBox(height: 20),
                    _buildRowInput(DSL, DSLPercent, 'DSL',
                        'DSL quantity is required', 'DSL percent is required'),
                    SizedBox(height: 20),
                    _buildRowInput(
                        HOME4G,
                        Home4GPercent,
                        'HOME 4G',
                        'Home 4G quantity is required',
                        'Home 4G percent is required'),
                    SizedBox(height: 20),
                    _buildRowInput(OC, OCPercent, 'OC',
                        'OC quantity is required', 'OC percent is required'),
                    SizedBox(height: 20),
                    _buildRowInput(
                        Devices,
                        DevicesPercent,
                        'Devices',
                        'Devices quantity is required',
                        'Devices percent is required'),
                    SizedBox(height: 30),

                    // Submit button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange[300]!, Colors.orange[500]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
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
                              home4gper: double.parse(Home4GPercent.text),
                              devicesper: double.parse(DevicesPercent.text),
                            );
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

// Helper function to create input rows
      },
    );
  }

  Widget _buildRowInput(
      TextEditingController controller1,
      TextEditingController controller2,
      String label,
      String errorText1,
      String errorText2) {
    return Row(
      children: [
        Expanded(
          child: _buildInputField(controller1, label, errorText1),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildInputField(controller2, label, errorText2,
              suffixIcon: Icons.percent),
        ),
      ],
    );
  }

// Custom function to build input fields
  Widget _buildInputField(
      TextEditingController controller, String label, String errorText,
      {IconData? suffixIcon}) {
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
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.orange)
              : null,
          contentPadding: EdgeInsets.all(15),
          labelStyle: TextStyle(color: Colors.orange),
        ),
      ),
    );
  }
}
