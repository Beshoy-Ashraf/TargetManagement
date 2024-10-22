import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/HomeLayout.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/shared/components/components.dart';

class NewInformation extends StatelessWidget {
  const NewInformation({super.key});

  @override
  Widget build(BuildContext context) {
    var title = TextEditingController();
    var description = TextEditingController();
    var FormKey = GlobalKey<FormState>();
    return BlocConsumer<Appcubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defualtAppbar(
              context: context,
              title: 'New Information',
            ),
            body: SingleChildScrollView(
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 177, 116, 102),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: title,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Title is required';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                            prefixIcon: Icon(Icons.title,
                                color: Colors.grey), // Added icon
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 177, 116, 102),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: description,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Description is required';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Description',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                            prefixIcon: Icon(Icons.description,
                                color: Colors.grey), // Added icon
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 20.0, bottom: 20.0),
                              child: TextButton(
                                onPressed: () async {
                                  Appcubit.get(context).pickPDF();
                                },
                                child: Text(
                                  'Select PDF File',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                      255, 245, 147, 0), // Button color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.check_circle,
                              color: Appcubit.get(context).result == null
                                  ? Colors.red
                                  : Colors.green,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 245, 147, 0),
                          border: Border.all(
                            color: Color.fromARGB(255, 177, 116, 102),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            if (FormKey.currentState!.validate()) {
                              Appcubit.get(context).addinformation(
                                title: title.text,
                                description: description.text,
                              );
                              navigateAndFinish(context, HomeLayout());
                            }
                          },
                          child: Text(
                            'Upload Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
