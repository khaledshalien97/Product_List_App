import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/cubit/cart/cart_cubit.dart';

class ButtonPlaceOrder extends StatelessWidget {
  const ButtonPlaceOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FilledButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepCyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Order Confirmed'),
                content: const Text('Your order has been placed successfully.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            context.read<CartCubit>().clear();
          },
          child: const Text('Place Order'),
        ),
      ),
    );
  }
}
