import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return const Center(child: Text("Your cart is empty 🛒"));
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10).r,
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            final product = state.items.keys.elementAt(index);
            final qty = state.items[product] ?? 1;

            return Card(
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: product.image,
                  width: 50.h,
                  height: 50.h,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
                title: Text(product.title),
                subtitle: Text(
                    "\$${product.price.toStringAsFixed(2)} x $qty = \$${(product.price * qty).toStringAsFixed(2)}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        context.read<CartBloc>().add(DecreaseQuantity(product));
                      },
                    ),
                    Text('$qty'),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        context.read<CartBloc>().add(IncreaseQuantity(product));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
