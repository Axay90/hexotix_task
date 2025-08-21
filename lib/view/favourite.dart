import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xfff6e7f2), Color(0xfff8e9f7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("My Favorites")),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state.favorites.isEmpty) {
              return const Center(child: Text("No favorites yet"));
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10).r,
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final product = state.favorites[index];
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
                    subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context
                            .read<FavoritesBloc>()
                            .add(ToggleFavorite(product));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
