import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';

import '../bloc/shopcategory_bloc.dart';

class ShopCategoryScreen extends StatefulWidget {
  const ShopCategoryScreen({super.key});

  @override
  State<ShopCategoryScreen> createState() => _ShopCategoryScreenState();
}

class _ShopCategoryScreenState extends State<ShopCategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopcategoryBloc>().add(GetShopCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Category"),
        centerTitle: true,
      ),
      body: BlocBuilder<ShopcategoryBloc, ShopcategoryState>(
        builder: (context, state) {
          return switch (state.status) {
            CubitStatus.success => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: state.shopCategories.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Center(
                      child: Text(state.shopCategories[index].name),
                    ),
                  );
                }),
            CubitStatus.failed => Center(
                child: IconButton.filled(
                    onPressed: () {
                      context
                          .read<ShopcategoryBloc>()
                          .add(GetShopCategoryEvent());
                    },
                    icon: const Icon(Icons.refresh)),
              ),
            _ => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          };
        },
      ),
    );
  }
}
