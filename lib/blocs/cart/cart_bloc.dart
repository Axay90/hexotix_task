import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>((event, emit) {
      final items = Map<Product, int>.from(state.items);
      items[event.product] = (items[event.product] ?? 0) + 1;
      emit(state.copyWith(items: items));
    });

    on<RemoveFromCart>((event, emit) {
      final items = Map<Product, int>.from(state.items);
      items.remove(event.product);
      emit(state.copyWith(items: items));
    });

    on<IncreaseQuantity>((event, emit) {
      final items = Map<Product, int>.from(state.items);
      if (items.containsKey(event.product)) {
        items[event.product] = (items[event.product] ?? 0) + 1;
      }
      emit(state.copyWith(items: items));
    });

    on<DecreaseQuantity>((event, emit) {
      final items = Map<Product, int>.from(state.items);
      if (items.containsKey(event.product)) {
        final currentQty = items[event.product] ?? 1;
        if (currentQty > 1) {
          items[event.product] = currentQty - 1;
        } else {
          items.remove(event.product);
        }
      }
      emit(state.copyWith(items: items));
    });
  }
}
