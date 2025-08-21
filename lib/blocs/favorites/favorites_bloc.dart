import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<ToggleFavorite>((event, emit) {
      final current = List<Product>.from(state.favorites);
      if (current.any((p) => p.id == event.product.id)) {
        current.removeWhere((p) => p.id == event.product.id);
      } else {
        current.add(event.product);
      }
      emit(state.copyWith(favorites: current));
    });
  }
}
