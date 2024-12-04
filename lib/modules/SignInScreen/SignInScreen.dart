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
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var usernameController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInSucessful) {
            navigateAndFinish(context, const HomeLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 30),
                        defualtTextinput(
                          password: false,
                          controller: emailController,
                          validate: (value) =>
                              value!.isEmpty ? 'Email must not be empty' : null,
                          Type: TextInputType.emailAddress,
                          label: 'Email',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 15),
                        defualtTextinput(
                          password: false,
                          controller: phoneController,
                          validate: (value) =>
                              value!.isEmpty ? 'Phone must not be empty' : null,
                          Type: TextInputType.phone,
                          label: 'Phone',
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(height: 15),
                        defualtTextinput(
                          password: false,
                          controller: usernameController,
                          validate: (value) => value!.isEmpty
                              ? 'Username must not be empty'
                              : null,
                          Type: TextInputType.text,
                          label: 'Username',
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        defualtTextinput(
                          password: SignInCubit.get(context).isPassword,
                          controller: passwordController,
                          validate: (value) => value!.isEmpty
                              ? 'Password must not be empty'
                              : null,
                          Type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: SignInCubit.get(context).isPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onIconPresses: () {
                            SignInCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        const SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! SignInLoadData,
                          builder: (context) => defualtButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SignInCubit.get(context).postRgister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  username: usernameController.text,
                                );
                              }
                            },
                            text: 'Register',
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateAndFinish(context, Login());
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
