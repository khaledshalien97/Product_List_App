import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onAdd;
  final VoidCallback onDetails;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      child: SizedBox(
        height: 340,
        child: InkWell(
          onTap: onDetails,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 0,
                    bottom: 160,
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail,
                      fit: BoxFit.fill,
                      placeholder: (_, __) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (_, __, ___) => const ColoredBox(
                        color: Color(0xffe9e9e9),
                        child: Center(child: Icon(Icons.broken_image_outlined)),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),

                          Expanded(
                            child: Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                height: 1.25,
                                color: Colors.black.withOpacity(0.85),
                              ),
                            ),
                          ),

                          const SizedBox(height: 4),

                          _Stars(rating: (product.rating ?? 0).toDouble()),

                          const SizedBox(height: 4),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "\$ ${product.price}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              Container(
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.deepCyan.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  onPressed: onAdd,
                                  icon: Icon(
                                    Icons.add_shopping_cart_rounded,
                                    color: AppColors.white,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  iconSize: 22,
                                  splashRadius: 22,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  const _Stars({required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    final full = rating.floor();
    final half = (rating - full) >= 0.25 && (rating - full) < 0.75;
    final widgets = <Widget>[];
    for (var i = 0; i < full && widgets.length < 5; i++) {
      widgets.add(
        const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFC107)),
      );
    }
    if (half && widgets.length < 5) {
      widgets.add(
        const Icon(Icons.star_half_rounded, size: 16, color: Color(0xFFFFC107)),
      );
    }
    while (widgets.length < 5) {
      widgets.add(
        const Icon(
          Icons.star_border_rounded,
          size: 16,
          color: Color(0xFFFFC107),
        ),
      );
    }
    return Row(children: widgets);
  }
}
