import 'dart:convert';

class Product {
  final int id;
  final String title;
  final double price;
  final String image;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] is int ? map['id'] : int.tryParse('${map['id']}') ?? 0,
      title: (map['title'] ?? '').toString(),
      price: (map['price'] is num)
          ? (map['price'] as num).toDouble()
          : double.tryParse('${map['price']}') ?? 0.0,
      image: (map['image'] ?? '').toString(),
    );
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'image': image,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Product && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
