import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:worker/core/extensions/context_extensions.dart';
import 'package:worker/core/extensions/validation.dart';

import '../../../../core/utils/main_button.dart';
import '../../../../core/utils/main_text_field.dart';
import '../../../../core/utils/toaster.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  40.verticalSpace,
                  Text(
                    'Profile',
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
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
                  15.verticalSpace,
                  MainTextField(
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/person.svg',
                      width: 16.sp,
                      height: 16.sp,
                      fit: BoxFit.scaleDown,
                    ),
                    text: 'Full Name',
                    validator: (text) {
                      if (text != null && text.isNotShortText()) {
                        return null;
                      } else {
                        return 'Please Enter A Valid Name';
                      }
                    },
                    controller: nameController,
                    hint: 'Steve Jobs',
                  ),
                  15.verticalSpace,
                  MainTextField(
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    text: 'Address',
                    validator: (text) {
                      if (text != null && text.isNotShortText()) {
                        return null;
                      } else {
                        return 'Address Invalidate';
                      }
                    },
                    controller: addressController,
                    hint: 'Aleppo Syria',
                  ),
                  15.verticalSpace,
                  MainTextField(
                    prefixIcon: const Icon(Icons.phone_android_rounded),
                    text: 'Phone',
                    validator: (text) {
                      if (text != null && text.isValidPhone()) {
                        return null;
                      } else {
                        return 'Phone Number Invalidate';
                      }
                    },
                    controller: phoneController,
                    hint: '+963932728290',
                  ),
                  15.verticalSpace,
                  15.verticalSpace,
                  MainButton(
                      height: 60.h,
                      text: 'Edit',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      }),
                  25.verticalSpace,
                ],
              ),
            )),
      ),
    );
  }
}
