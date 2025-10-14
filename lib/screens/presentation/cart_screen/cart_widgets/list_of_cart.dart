import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/cubit/cart/cart_cubit.dart';
import 'package:product_list_app/cubit/cart/cart_state.dart';

Expanded listofCart(CartState state, BuildContext context) {
  return Expanded(
    child: ListView.separated(
      itemCount: state.items.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (_, i) {
        final it = state.items[i];
        return ListTile(
          leading: Image.network(
            it.product.thumbnail,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(it.product.title),
          subtitle: Text('\$${it.product.price.toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () =>
                    context.read<CartCubit>().decrement(it.product.id),
              ),
              Text(it.qty.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () =>
                    context.read<CartCubit>().increment(it.product.id),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Color(0xffEC3636),
                onPressed: () =>
                    context.read<CartCubit>().remove(it.product.id),
              ),
            ],
          ),
        );
      },
    ),
  );
}
