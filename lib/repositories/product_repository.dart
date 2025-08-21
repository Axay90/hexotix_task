import 'dart:convert';

import 'package:hexotix_task/utils/api_url.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductRepository {


  Future<List<Product>> fetchProducts() async {
    try {
      final res = await http
          .get(Uri.parse(ApiUrls.productUrl))
          .timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final List list = json.decode(res.body) as List;
        return list
            .map((e) => Product.fromMap(e as Map<String, dynamic>))
            .toList();
      }
      return _mockProducts();
    } catch (_) {

      return _mockProducts();
    }
  }

  List<Product> _mockProducts() {
    const data = [
      {
        'id': 1,
        'title': 'Mock T‑Shirt',
        'price': 19.99,
        'image': 'https://via.placeholder.com/300x300.png?text=T-Shirt',
      },
      {
        'id': 2,
        'title': 'Mock Headphones',
        'price': 49.99,
        'image': 'https://via.placeholder.com/300x300.png?text=Headphones',
      },
      {
        'id': 3,
        'title': 'Mock Backpack',
        'price': 39.99,
        'image': 'https://via.placeholder.com/300x300.png?text=Backpack',
      },
      {
        'id': 4,
        'title': 'Mock Watch',
        'price': 89.99,
        'image': 'https://via.placeholder.com/300x300.png?text=Watch',
      },
    ];
    return data.map((e) => Product.fromMap(e)).toList();
  }
}
