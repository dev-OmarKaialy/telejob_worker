import 'package:flutter/material.dart';
import 'package:worker/core/extensions/widget_extensions.dart';
import 'package:worker/features/joprequest/presentation/pages/jobs_reqeusts.dart';
import 'package:worker/features/shop/presentation/pages/shop_screen.dart';
import 'package:worker/features/shopcategory/presentation/pages/shop_category_screen.dart';

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
        ],
      ),
    );
  }
}
