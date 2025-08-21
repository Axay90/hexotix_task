import '../../models/product.dart';

class FavoritesState {
  final List<Product> favorites;

  const FavoritesState({this.favorites = const []});

  FavoritesState copyWith({List<Product>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  bool isFav(int id) => favorites.any((p) => p.id == id);
}
