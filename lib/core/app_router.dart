import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list_app/data/models/product_model.dart';
import 'package:product_list_app/screens/presentation/auth_screen/checkout_screen/checkout_screen.dart';
import 'package:product_list_app/screens/presentation/auth_screen/login_screen/login_screen.dart';
import 'package:product_list_app/screens/presentation/auth_screen/register_screen/register_screen.dart';
import 'package:product_list_app/screens/presentation/cart_screen/cart_screen.dart';
import 'package:product_list_app/screens/presentation/product_screen/product_list_screen.dart';
import 'package:product_list_app/screens/presentation/product_screen/product_details_screen.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Hello, Product App 👋'));
  }
}

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const ProductListScreen()),
    GoRoute(path: '/cart', builder: (_, __) => const CartScreen()),
    GoRoute(
      path: '/details',
      builder: (context, state) => ProductDetailsScreen(product: state.extra as ProductModel),
    ),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
    GoRoute(path: '/checkout', builder: (_, __) => const CheckoutScreen()),
  ],
);
