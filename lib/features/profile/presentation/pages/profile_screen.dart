import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worker/core/utils/main_button.dart';
import 'package:worker/core/utils/main_text_field.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';

import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == CubitStatus.success) {
            nameController.text = state.profile!.worker.name;
            phoneController.text = state.profile!.worker.phone;
            emailController.text = state.profile!.worker.email;
            addressController.text = state.profile!.worker.address;
          }
        },
        builder: (context, state) {
          return switch (state.status) {
            CubitStatus.success => SingleChildScrollView(
                padding: const EdgeInsetsDirectional.all(25),
                child: Column(
                  children: [
                    20.verticalSpace,
                    MainTextField(
                      controller: nameController,
                      text: 'Name',
                    ),
                    20.verticalSpace,
                    MainTextField(
                      controller: emailController,
                      text: 'Email',
                    ),
                    20.verticalSpace,
                    MainTextField(
                      controller: phoneController,
                      text: 'Phone',
                    ),
                    20.verticalSpace,
                    MainTextField(
                      controller: addressController,
                      text: 'Address',
                    ),
                    20.verticalSpace,
                    MainButton(
                        text: 'Edit',
                        onPressed: () {
                          context.read<ProfileBloc>().add(UpdateProfile());
                        })
                  ],
                ),
              ),
            CubitStatus.failed => Center(
                child: IconButton.filled(
                    onPressed: () {
                      context.read<ProfileBloc>().add(GetProfile());
                    },
                    icon: const Icon(Icons.replay)),
              ),
            _ => const Center(
                child: CircularProgressIndicator(),
              ),
          };
        },
      ),
    );
  }
}
