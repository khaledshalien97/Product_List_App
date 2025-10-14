import 'package:flutter/material.dart';
import 'package:product_list_app/cubit/cart/cart_state.dart';

Padding totalTextCart(CartState state) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      'Total: \$${state.total.toStringAsFixed(2)}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
