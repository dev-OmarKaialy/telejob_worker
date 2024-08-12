import 'package:flutter/material.dart';
import 'package:worker/core/extensions/widget_extensions.dart';
import 'package:worker/core/utils/main_button.dart';
import 'package:worker/core/utils/toaster.dart';
import 'package:worker/features/joprequest/presentation/pages/jobs_reqeusts.dart';
import 'package:worker/features/shop/data/models/orders_model.dart';
import 'package:worker/features/shop/presentation/pages/shop_screen.dart';
import 'package:worker/features/shopcategory/presentation/pages/shop_category_screen.dart';

import '../../../../core/unified_api/delete_api.dart';
import '../../../../core/unified_api/get_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          const Card(
            child: Center(
              child: Text(
                'Job Requests',
              ),
            ),
          ).onTap(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const JobsReqeusts();
            }));
          }),
          const Card(
            child: Center(
              child: Text(
                'Shops',
              ),
            ),
          ).onTap(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ShopScreen();
            }));
          }),
          const Card(
            child: Center(
              child: Text(
                'Categories',
              ),
            ),
          ).onTap(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ShopCategoryScreen();
            }));
          }),
          const Card(
            child: Center(
              child: Text(
                'Orders',
              ),
            ),
          ).onTap(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const OrdersScreen();
            }));
          }),
        ],
      ),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future(() async {
          final getApi = GetApi<OrdersModel>(
              uri: Uri.parse('https://telejob.onrender.com/worker/orders'),
              fromJson: ordersModelFromJson);
          return await getApi.callRequest();
        }),
        builder: (context, snapshot) {
          return switch (snapshot.hasData) {
            true => ListView.builder(
                itemCount: snapshot.data!.orders?.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.purple])),
                    child: Theme(
                      data: ThemeData.light().copyWith(
                          expansionTileTheme: const ExpansionTileThemeData(
                        backgroundColor: Colors.transparent,
                        collapsedBackgroundColor: Colors.transparent,
                        textColor: Colors.white,
                      )),
                      child: ExpansionTile(
                        title: Text(
                            'Order No #${snapshot.data!.orders![index].id!.substring(0, 4)}'),
                        children: [
                          if (snapshot.data!.orders![index].status == 'Pending')
                            MainButton(
                                text: 'Cancel',
                                onPressed: () async {
                                  Toaster.showLoading();
                                  final deleteApi = DeleteApi(
                                      uri: Uri.parse(
                                          'https://telejob.onrender.com/worker/order/${snapshot.data!.orders![index].id}'),
                                      fromJson: (s) {});
                                  await deleteApi.callRequest();
                                  Toaster.closeLoading();
                                  setState(() {});
                                }),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  'Shop :${snapshot.data!.orders![index].shop?.name ?? ''}',
                                  style: const TextStyle(color: Colors.white)),
                              Text(
                                  'Description :${snapshot.data!.orders![index].description ?? ''}',
                                  style: const TextStyle(color: Colors.white)),
                              Text(
                                  'Status :${snapshot.data!.orders![index].status ?? ''}',
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
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
