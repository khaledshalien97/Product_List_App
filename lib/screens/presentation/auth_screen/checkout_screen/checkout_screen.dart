import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/cubit/auth/auth_cubit.dart';
import 'package:product_list_app/cubit/cart/cart_cubit.dart';
import 'package:product_list_app/screens/common_widgets/commo_app_bar.dart';
import 'package:product_list_app/screens/presentation/auth_screen/checkout_screen/checkout_widgets/button_place_order.dart';
import 'package:product_list_app/screens/presentation/auth_screen/checkout_screen/checkout_widgets/list_of_check_out.dart';
import 'package:product_list_app/screens/presentation/cart_screen/cart_widgets/total_text_cart.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final cart = context.watch<CartCubit>().state;
    if (!auth.isAuthed) {
      return const Scaffold(
        body: Center(child: Text('Unauthorized. Please login.')),
      );
    }
    return Scaffold(
      appBar: commonAppBar(title: 'Checkout'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hello, ${auth.user?.email}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 12),
            ListofCheckOut(cart: cart),
            const SizedBox(height: 12),
            totalTextCart(cart),
            ButtonPlaceOrder(),
          ],
        ),
      ),
    );
  }
}
