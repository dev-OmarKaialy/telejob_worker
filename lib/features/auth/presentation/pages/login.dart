import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worker/core/extensions/context_extensions.dart';
import 'package:worker/core/extensions/validation.dart';
import 'package:worker/core/utils/main_button.dart';
import 'package:worker/core/utils/main_text_field.dart';
import 'package:worker/core/utils/toaster.dart';
import 'package:worker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worker/features/auth/presentation/pages/register.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == CubitStatus.loading) {
          Toaster.showLoading();
        } else {
          Toaster.closeLoading();
          if (state.status == CubitStatus.success) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    80.verticalSpace,
                    Text(
                      'Welcome Back!',
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    10.verticalSpace,
                    Text(
                      'Enter your email & password',
                      style: context.textTheme.bodyMedium,
                    ),
                    10.verticalSpace,
                    MainTextField(
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/email.svg',
                        width: 16.sp,
                        height: 16.sp,
                        fit: BoxFit.scaleDown,
                      ),
                      text: 'E-mail',
                      validator: (text) {
                        if (text != null && text.isValidEmail()) {
                          return null;
                        } else {
                          return 'Email Incorrect';
                        }
                      },
                      controller: emailController,
                      hint: 'example@mail.com',
                    ),
                    25.verticalSpace,
                    MainTextField(
                      validator: (text) {
                        if (text != null && text.isValidPassword()) {
                          return null;
                        } else {
                          return 'Password Should Be At Least 5 Characters';
                        }
                      },
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/password.svg',
                        width: 16.sp,
                        height: 16.sp,
                        fit: BoxFit.scaleDown,
                      ),
                      text: 'Password',
                      controller: passwordController,
                      hint: '********',
                      isPassword: true,
                    ),
                    10.verticalSpace,
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          style: context.textTheme.titleSmall
                              ?.copyWith(color: context.primaryColor),
                        ),
                      ),
                    ),
                    25.verticalSpace,
                    MainButton(
                        height: 60.h,
                        text: 'Login',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(LoginEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        }),
                    25.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New User?', style: context.textTheme.bodyLarge),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ));
                            },
                            child: Text(
                              'Sign Up',
                              style: context.textTheme.bodyLarge
                                  ?.copyWith(color: context.primaryColor),
                            ))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
