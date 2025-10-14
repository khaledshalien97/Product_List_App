import 'package:equatable/equatable.dart';
import 'package:product_list_app/data/models/review_model.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final int stock;
  final String thumbnail;
  final List<String> images;
  final List<ReviewModel> reviews;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.images,
    this.reviews = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> j) => ProductModel(
    id: j['id'],
    title: j['title'] ?? '',
    description: j['description'] ?? '',
    category: j['category'] ?? 'general',
    price: (j['price'] as num).toDouble(),
    rating: (j['rating'] as num?)?.toDouble() ?? 0,
    stock: (j['stock'] as num?)?.toInt() ?? 0,
    thumbnail:
        j['thumbnail'] ??
        (j['images'] != null && (j['images'] as List).isNotEmpty
            ? j['images'][0]
            : ''),

    images:
        (j['images'] as List?)?.map((e) => e.toString()).toList() ?? const [],
    reviews:
        (j['reviews'] as List<dynamic>?)
            ?.map((e) => ReviewModel.fromJson(e))
            .toList() ??
        const [],
  );

  @override
  List<Object?> get props => [id, title, price, stock];
}
