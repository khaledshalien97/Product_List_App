import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/core/app_router.dart';
import 'package:product_list_app/core/theme.dart';
import 'package:product_list_app/data/repositories/auth_repository.dart';
import 'package:product_list_app/data/repositories/product_repository.dart';
import 'package:product_list_app/data/services/product_api.dart';
import 'package:product_list_app/firebase_options.dart';
import 'package:product_list_app/cubit/auth/auth_cubit.dart';
import 'package:product_list_app/cubit/cart/cart_cubit.dart';
import 'package:product_list_app/cubit/product/product_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const AppBootstrap());
}

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});
  @override
  Widget build(BuildContext context) {
    final repo = ProductRepository(ProductApi());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit(repo)..load()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => AuthCubit(AuthRepository())),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Product List',
      theme: appTheme(),
      routerConfig: router,
    );
  }
}
