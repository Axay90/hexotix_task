import '../../models/product.dart';

class CartState {
  final Map<Product, int> items;

  const CartState({this.items = const {}});

  CartState copyWith({Map<Product, int>? items}) =>
      CartState(items: items ?? this.items);
}
