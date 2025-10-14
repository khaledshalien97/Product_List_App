import 'package:equatable/equatable.dart';
import 'package:product_list_app/data/models/product_model.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductModel> products;
  final List<ProductModel> visible;
  final String? error;
  final String? categoryFilter;
  final String? sortBy;
  final double? minPrice;
  final double? maxPrice;

  final List<String> categories;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.visible = const [],
    this.error,
    this.categoryFilter,
    this.sortBy,
    this.minPrice,
    this.maxPrice,
    this.categories = const [],
  });

  ProductState copyWith({
    ProductStatus? status,
    List<ProductModel>? products,
    List<ProductModel>? visible,
    String? error,
    String? categoryFilter,
    String? sortBy,
    double? minPrice,
    double? maxPrice,
    List<String>? categories,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      visible: visible ?? this.visible,
      error: error,
      categoryFilter: categoryFilter ?? this.categoryFilter,
      sortBy: sortBy ?? this.sortBy,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
    status,
    products,
    visible,
    error,
    categoryFilter,
    sortBy,
    minPrice,
    maxPrice,
    categories,
  ];
}
