import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';
import 'package:product_list_app/data/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void add(ProductModel product) {
    final idx = state.items.indexWhere((e) => e.product.id == product.id);
    if (idx == -1) {
      final updated = List.of(state.items)..add(CartItem(product, 1));
      emit(CartState(items: updated));
    } else {
      final updated = List.of(state.items);
      updated[idx] = updated[idx].copyWith(qty: updated[idx].qty + 1);
      emit(CartState(items: updated));
    }
  }

  void increment(int productId) {
    final idx = state.items.indexWhere((e) => e.product.id == productId);
    if (idx == -1) return;
    final updated = List.of(state.items);
    updated[idx] = updated[idx].copyWith(qty: updated[idx].qty + 1);
    emit(CartState(items: updated));
  }

  void decrement(int productId) {
    final idx = state.items.indexWhere((e) => e.product.id == productId);
    if (idx == -1) return;
    final it = state.items[idx];
    if (it.qty <= 1) {
      remove(productId);
    } else {
      final updated = List.of(state.items);
      updated[idx] = it.copyWith(qty: it.qty - 1);
      emit(CartState(items: updated));
    }
  }

  void remove(int productId) {
    emit(
      CartState(
        items: state.items.where((e) => e.product.id != productId).toList(),
      ),
    );
  }

  void clear() => emit(const CartState());
}
