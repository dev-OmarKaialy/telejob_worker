import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worker/core/extensions/widget_extensions.dart';
import 'package:worker/core/utils/main_button.dart';
import 'package:worker/core/utils/main_text_field.dart';
import 'package:worker/core/utils/toaster.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:worker/features/shop/presentation/bloc/shop_bloc.dart';

import '../../../../core/unified_api/post_api.dart';

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

  final ValueNotifier<int?> selectedProduct = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var textEditingController = TextEditingController();
          if (selectedProduct.value != null) {
            showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Center(
                            child: Text('Create Order'),
                          ),
                          20.verticalSpace,
                          MainTextField(
                            text: 'Description',
                            controller: textEditingController,
                          ),
                          20.verticalSpace,
                          MainButton(
                              text: 'Send',
                              onPressed: () async {
                                Toaster.showLoading();
                                final postApi = PostApi(
                                    uri: Uri.parse(
                                        'https://telejob.onrender.com/worker/order'),
                                    body: {
                                      'description': textEditingController.text,
                                      'shopId': widget.id
                                    },
                                    fromJson: (s) {});
                                await postApi.callRequest();
                                Toaster.closeLoading();
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              })
                        ],
                      ),
                    ),
                  );
                });
          } else {
            Toaster.showToast('Please Selcet A Product First');
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return switch (state.productsStatus) {
            CubitStatus.success => state.products.isEmpty
                ? const Center(
                    child: Text('No Data Yet'),
                  )
                : ValueListenableBuilder(
                    valueListenable: selectedProduct,
                    builder: (context, value, _) {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                      color: value == index
                                          ? Colors.black
                                          : Colors.transparent)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      state.products[index].imagesUrls?[0] ??
                                          '',
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.refresh);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Center(
                                    child:
                                        Text(state.products[index].name ?? ''),
                                  ),
                                ],
                              ),
                            ).onTap(() {
                              selectedProduct.value =
                                  selectedProduct.value == index ? null : index;
                            });
                          });
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
