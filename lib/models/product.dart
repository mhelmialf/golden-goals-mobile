// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    String id;
    String productName;
    int price;
    int stock;
    int productViews;
    String category;
    String description;
    String? thumbnail;
    DateTime createdAt;
    bool isFeatured;
    dynamic userId;
    String username;

    Product({
        required this.id,
        required this.productName,
        required this.price,
        required this.stock,
        required this.productViews,
        required this.category,
        required this.description,
        required this.thumbnail,
        required this.createdAt,
        required this.isFeatured,
        required this.userId,
        required this.username,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        stock: json["stock"],
        productViews: json["product_views"],
        category: json["category"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        createdAt: DateTime.parse(json["created_at"]),
        isFeatured: json["is_featured"],
        userId: json["user_id"],
        username: json["username"] ?? 'Anonymous',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "stock": stock,
        "product_views": productViews,
        "category": category,
        "description": description,
        "thumbnail": thumbnail,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
        "user_id": userId,
        "username": username,
    };
}
