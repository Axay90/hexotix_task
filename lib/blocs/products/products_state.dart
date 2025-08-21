import '../../models/product.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState {
  final ProductsStatus status;
  final List<Product> products;
  final String? error;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.error,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    String? error,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error,
    );
  }
}
