import 'package:flutter/material.dart';
import 'package:product_list_app/cubit/cart/cart_state.dart';

Padding totlaTextCheckOut(CartState cart) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      'Total: \$${cart.total.toStringAsFixed(2)}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
