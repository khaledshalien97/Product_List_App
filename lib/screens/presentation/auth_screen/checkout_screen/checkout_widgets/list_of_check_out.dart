import 'package:flutter/material.dart';
import 'package:product_list_app/cubit/cart/cart_state.dart';

class ListofCheckOut extends StatelessWidget {
  const ListofCheckOut({super.key, required this.cart});

  final CartState cart;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: cart.items.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (_, i) {
          final it = cart.items[i];
          return ListTile(
            title: Text(it.product.title),
            subtitle: Text(
              'Qty: ${it.qty} × \$${it.product.price.toStringAsFixed(2)}',
            ),
            trailing: Text('\$${it.total.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
