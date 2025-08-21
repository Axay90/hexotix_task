import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';
import '../blocs/products/products_bloc.dart';
import '../blocs/products/products_event.dart';
import '../blocs/products/products_state.dart';
import '../models/product.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsBloc>().add(LoadProducts());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProductsStatus.failure) {
            return Center(child: Text("Error: ${state.error}"));
          } else if (state.status == ProductsStatus.success) {
            final products = state.products;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _ProductCard(product: product);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.r),
            child: Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          Text(
            "\$${product.price.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favState) {
                  final isFav = favState.isFav(product.id);
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<FavoritesBloc>()
                          .add(ToggleFavorite(product));
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: Tween<double>(begin: 0.6, end: 1.0)
                              .animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutBack,
                          )),
                          child: child,
                        );
                      },
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey<bool>(isFav),
                        color: isFav ? Colors.red : Colors.grey,
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  context.read<CartBloc>().add(AddToCart(product));

                  Fluttertoast.showToast(
                    msg: "Added to cart 🛒",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 14.sp,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.all(6).r,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.add_shopping_cart, color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
