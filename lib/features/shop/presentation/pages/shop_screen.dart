import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worker/core/extensions/context_extensions.dart';
import 'package:worker/core/extensions/widget_extensions.dart';
import 'package:worker/core/unified_api/api_variables.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:worker/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:worker/features/shop/presentation/pages/products_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(GetShopsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
        centerTitle: true,
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return switch (state.status) {
            CubitStatus.success => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Container(
                  width: 1.sw,
                  height: .5.sh,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: context.theme.highlightColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    ApiVariables().imageUrl + state.shops[index].photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(state.shops[index].name),
                      );
                    },
                  ),
                ).onTap(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductsScreen(id: state.shops[index].id),
                      ));
                }),
                itemCount: state.shops.length,
              ),
            CubitStatus.failed => Center(
                child: ElevatedButton(
                    onPressed: () {
                      context.read<ShopBloc>().add(GetShopsEvent());
                    },
                    child: const Text('Try Again')),
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
