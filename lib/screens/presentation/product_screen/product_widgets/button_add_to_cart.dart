import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/cubit/cart/cart_cubit.dart';
import 'package:product_list_app/data/models/product_model.dart';

class ButtonAddtoCart extends StatelessWidget {
  const ButtonAddtoCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FilledButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepCyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Add to Cart'),
          onPressed: () {
            context.read<CartCubit>().add(product);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Added to cart')));
          },
        ),
      ),
    );
  }
}
