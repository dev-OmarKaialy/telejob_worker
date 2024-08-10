import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worker/features/auth/presentation/pages/login.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:worker/features/joprequest/presentation/bloc/joprequest_bloc.dart';
import 'package:worker/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:worker/features/shop/presentation/bloc/shop_bloc.dart';

import 'core/services/shared_preferences_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
      BlocProvider(
        create: (context) => ProfileBloc(),
      ),
      BlocProvider(
        create: (context) => CategoriesBloc()..add(IndexCategories()),
      ),
      BlocProvider(
        create: (context) => ShopBloc(),
      ),
      BlocProvider(
        create: (context) => JoprequestBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(primaryColor: Colors.cyan),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const LoginScreen(),
      ),
    );
  }
}
