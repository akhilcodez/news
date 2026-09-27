class ProductModel {
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  int quantity;

  ProductModel({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] != null)
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      imageUrl: json['imageUrl']?.toString() ?? '',
      quantity: json['quantity'] != null
          ? int.tryParse(json['quantity'].toString()) ?? 1
          : 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  ProductModel copyWith({
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    int? quantity,
  }) {
    return ProductModel(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}
