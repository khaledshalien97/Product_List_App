import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list_app/cubit/cart/cart_cubit.dart';
import 'package:product_list_app/cubit/product/product_cubit.dart';
import 'package:product_list_app/cubit/product/product_state.dart';
import 'package:product_list_app/screens/presentation/product_screen/product_widgets/product_card.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ProductStatus.failure:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error ?? 'Error'),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => context.read<ProductCubit>().load(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            case ProductStatus.success:
              if (state.visible.isEmpty) {
                return const Center(
                  child: Text('No products match your filters.'),
                );
              }
              return GridView.builder(
                itemCount: state.visible.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 340,
                ),

                itemBuilder: (_, i) {
                  final p = state.visible[i];
                  return ProductCard(
                    product: p,
                    onAdd: () => context.read<CartCubit>().add(p),
                    onDetails: () => context.push('/details', extra: p),
                  );
                },
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
