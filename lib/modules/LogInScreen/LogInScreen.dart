import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/modules/LogInScreen/LoginCubit/LogInCubit.dart';
import 'package:target_manangment/modules/LogInScreen/LoginCubit/LogInStates.dart';
import 'package:target_manangment/modules/SignInScreen/SignInScreen.dart';
import 'package:target_manangment/shared/components/components.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var EmailController = TextEditingController();
    var PasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              showtoast(msg: state.error, state: ToastStates.ERROR);
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
                            password: LoginCubit.get(context).isPassword,
                            controller: PasswordController,
                            validate: (value) => value!.isEmpty
                                ? 'Password must not be empty'
                                : null,
                            Type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefixIcon: Icons.lock,
                            suffixIcon: LoginCubit.get(context).Suffix,
                            onIconPresses: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginloadingState,
                            builder: (context) => defualtButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).postLogin(
                                      email: EmailController.text,
                                      password: PasswordController.text,
                                      context: context);
                                } else {
                                  print('Not Valid');
                                }
                              },
                              text: 'LogIn',
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('does not have account??'),
                              TextButton(
                                  onPressed: () {
                                    navigateAndFinish(context, SignIn());
                                  },
                                  child: Text('Register')),
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
