import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/data/repositories/product_repository.dart';
import 'package:product_list_app/data/models/product_model.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repo;
  ProductCubit(this.repo) : super(const ProductState());

  Future<void> load() async {
    emit(state.copyWith(status: ProductStatus.loading, error: null));
    try {
      final items = await repo.getAll();

      final prices = items.map((e) => e.price);
      final minP = prices.isEmpty
          ? 0.0
          : prices.reduce((a, b) => a < b ? a : b);
      final maxP = prices.isEmpty
          ? 0.0
          : prices.reduce((a, b) => a > b ? a : b);
      final cats = items.map((e) => e.category).toSet().toList()..sort();

      final visible = _apply(
        items,
        category: null,
        sortBy: null,
        minPrice: minP,
        maxPrice: maxP,
      );

      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: items,
          visible: visible,
          categories: cats,
          minPrice: minP,
          maxPrice: maxP,
          categoryFilter: null,
          sortBy: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.failure, error: e.toString()));
    }
  }

  void setCategory(String? cat) {
    final v = _apply(
      state.products,
      category: cat,
      sortBy: state.sortBy,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
    );
    emit(state.copyWith(categoryFilter: cat, visible: v));
  }

  void setSort(String? sortBy) {
    final v = _apply(
      state.products,
      category: state.categoryFilter,
      sortBy: sortBy,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
    );
    emit(state.copyWith(sortBy: sortBy, visible: v));
  }

  void setPriceRange(double minP, double maxP) {
    final v = _apply(
      state.products,
      category: state.categoryFilter,
      sortBy: state.sortBy,
      minPrice: minP,
      maxPrice: maxP,
    );
    emit(state.copyWith(minPrice: minP, maxPrice: maxP, visible: v));
  }

  List<ProductModel> _apply(
    List<ProductModel> base, {
    String? category,
    String? sortBy,
    double? minPrice,
    double? maxPrice,
  }) {
    Iterable<ProductModel> it = base;

    if (category != null && category.isNotEmpty) {
      it = it.where((p) => p.category.toLowerCase() == category.toLowerCase());
    }
    if (minPrice != null) it = it.where((p) => p.price >= minPrice);
    if (maxPrice != null) it = it.where((p) => p.price <= maxPrice);

    final list = it.toList();
    switch (sortBy) {
      case 'price-asc':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price-desc':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        break;
    }
    return list;
  }
}
