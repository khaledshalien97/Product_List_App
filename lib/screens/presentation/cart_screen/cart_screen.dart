import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/cubit/cart/cart_cubit.dart';
import 'package:product_list_app/cubit/cart/cart_state.dart';
import 'package:product_list_app/screens/common_widgets/commo_app_bar.dart';
import 'package:product_list_app/screens/presentation/cart_screen/cart_widgets/button_checkout.dart';
import 'package:product_list_app/screens/presentation/cart_screen/cart_widgets/list_of_cart.dart';
import 'package:product_list_app/screens/presentation/cart_screen/cart_widgets/total_text_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: 'Your Cart'),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (_, state) {
            if (state.items.isEmpty) {
              return const Center(child: Text('Cart is empty'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                listofCart(state, context),
                totalTextCart(state),
                ButtonCheckOut(),
              ],
            );
          },
        ),
      ),
    );
  }
}
