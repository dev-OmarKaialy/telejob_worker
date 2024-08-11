import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker/core/extensions/widget_extensions.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:worker/features/shop/presentation/bloc/shop_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(GetShopProductssEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return switch (state.productsStatus) {
            CubitStatus.success => state.products.isEmpty
                ? const Center(
                    child: Text('No Data Yet'),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Center(
                          child: Text(state.products[index].name ?? ''),
                        ),
                      );
                    }),
            CubitStatus.failed => Center(
                child: const Icon(Icons.refresh).onTap(() {
                  context
                      .read<ShopBloc>()
                      .add(GetShopProductssEvent(id: widget.id));
                }),
              ),
            CubitStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
