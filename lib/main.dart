import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexotix_task/blocs/products/products_bloc.dart';
import 'package:hexotix_task/repositories/product_repository.dart';
import 'package:hexotix_task/view/splash.dart';

import 'blocs/cart/cart_bloc.dart';
import 'blocs/favorites/favorites_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductsBloc(ProductRepository())),
        BlocProvider(create: (_) => FavoritesBloc()),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                ),
                scaffoldBackgroundColor: Colors.transparent,
                useMaterial3: true,
              ),
              home: SplashPage(),
            );
          }),
    );
  }
}
