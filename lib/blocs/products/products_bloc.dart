import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository repo;

  ProductsBloc(this.repo) : super(const ProductsState()) {
    on<LoadProducts>((event, emit) async {
      emit(state.copyWith(status: ProductsStatus.loading));
      try {
        final List<Product> data = await repo.fetchProducts();
        emit(state.copyWith(status: ProductsStatus.success, products: data));
      } catch (e) {
        emit(state.copyWith(
            status: ProductsStatus.failure, error: e.toString()));
      }
    });
  }
}
