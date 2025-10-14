import 'package:equatable/equatable.dart';
import 'package:product_list_app/data/models/product_model.dart';

class CartItem extends Equatable {
  final ProductModel product;
  final int qty;

  const CartItem(this.product, this.qty);

  CartItem copyWith({ProductModel? product, int? qty}) =>
      CartItem(product ?? this.product, qty ?? this.qty);

  double get total => product.price * qty;

  @override
  List<Object?> get props => [product, qty];
}

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get total =>
      items.fold(0, (sum, item) => sum + item.product.price * item.qty);

  @override
  List<Object?> get props => [items];
}
