import 'package:flutter/material.dart';
import 'package:product_list_app/data/models/product_model.dart'
    show ProductModel;

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Text(
          product.title,
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, size: 18, color: Colors.amber),
            const SizedBox(width: 4),
            Text(product.rating.toStringAsFixed(2)),
            const SizedBox(width: 12),
            Text(
              '(${product.stock} in stock)',
              style: TextStyle(
                color: product.stock <= 10 ? Colors.red : Colors.grey,
              ),
            ),
            const Spacer(),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),

        const SizedBox(height: 12),
        Text(product.description),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(Icons.category, size: 18),
            const SizedBox(width: 6),
            Text(product.category),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
