import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/data/models/product_model.dart';
import 'package:product_list_app/screens/common_widgets/commo_app_bar.dart';
import 'package:product_list_app/screens/presentation/product_screen/product_widgets/button_add_to_cart.dart'
    show ButtonAddtoCart;
import 'package:product_list_app/screens/presentation/product_screen/product_widgets/comments_info.dart';
import 'package:product_list_app/screens/presentation/product_screen/product_widgets/product_info.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  List<String> get _images => widget.product.images.isNotEmpty
      ? widget.product.images
      : [widget.product.thumbnail];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: commonAppBar(title: product.title),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          imageofProduct(),
          ProductInfo(product: product),
          CommentsInfo(product: product),
          ButtonAddtoCart(product: product),
        ],
      ),
    );
  }

  Stack imageofProduct() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CarouselSlider.builder(
            carouselController: _controller,
            itemCount: _images.length,
            itemBuilder: (context, index, _) {
              final url = _images[index];
              return CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.fill,
                width: double.infinity,
                placeholder: (_, __) => const SizedBox(
                  height: 240,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (_, __, ___) => const SizedBox(
                  height: 240,
                  child: Center(child: Icon(Icons.broken_image_outlined)),
                ),
              );
            },
            options: CarouselOptions(
              height: 240,
              viewportFraction: 1,
              enlargeCenterPage: false,
              enableInfiniteScroll: _images.length > 1,
              onPageChanged: (index, _) => setState(() => _current = index),
            ),
          ),
        ),

        if (_images.length > 1)
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_current + 1}/${_images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

        if (_images.length > 1)
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (i) {
                final isActive = i == _current;
                return GestureDetector(
                  onTap: () => _controller.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 18 : 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.deepCyan : Colors.white70,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
