import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/HomeLayout.dart';
import 'package:target_manangment/modules/LogInScreen/LogInScreen.dart';
import 'package:target_manangment/modules/SignInScreen/SignInCubit/SignInCubit.dart';
import 'package:target_manangment/modules/SignInScreen/SignInCubit/SignInStates.dart';
import 'package:target_manangment/shared/components/components.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var EmailController = TextEditingController();
    var PasswordController = TextEditingController();
    var PhoneController = TextEditingController();
    var usernameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (BuildContext context) => SignInCubit(),
        child: BlocConsumer<SignInCubit, SignInStates>(
          listener: (context, state) {
            if (state is SignInSucessful) {
              navigateAndFinish(context, const SignIn());
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            'login now to enjoy with our offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defualtTextinput(
                            password: false,
                            controller: EmailController,
                            validate: (value) => value!.isEmpty
                                ? 'Email must not be empty'
                                : null,
                            Type: TextInputType.emailAddress,
                            label: 'Email',
                            prefixIcon: Icons.email,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defualtTextinput(
                            password: false,
                            controller: PhoneController,
                            validate: (value) => value!.isEmpty
                                ? 'Phone must not be empty'
                                : null,
                            Type: TextInputType.emailAddress,
                            label: 'Phone',
                            prefixIcon: Icons.phone,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defualtTextinput(
                            password: false,
                            controller: usernameController,
                            validate: (value) => value!.isEmpty
                                ? 'username must not be empty'
                                : null,
                            Type: TextInputType.emailAddress,
                            label: 'username',
                            prefixIcon: Icons.location_city,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defualtTextinput(
                            password: SignInCubit.get(context).isPassword,
                            controller: PasswordController,
                            validate: (value) => value!.isEmpty
                                ? 'Password must not be empty'
                                : null,
                            Type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefixIcon: Icons.lock,
                            suffixIcon: SignInCubit.get(context).Suffix,
                            onIconPresses: () {
                              SignInCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! SignInLoadData,
                            builder: (context) => defualtButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SignInCubit.get(context).postRgister(
                                    email: EmailController.text,
                                    password: PasswordController.text,
                                    phone: PhoneController.text,
                                    username: usernameController.text,
                                  );
                                } else {
                                  print('Not Valid');
                                }
                              },
                              text: 'register',
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('do you have account??'),
                              TextButton(
                                  onPressed: () {
                                    navigateAndFinish(context, Login());
                                  },
                                  child: Text('LogIn')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
