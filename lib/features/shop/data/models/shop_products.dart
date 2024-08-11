// To parse this JSON data, do
//
//     final getShopProducts = getShopProductsFromJson(jsonString);

import 'dart:convert';

GetShopProducts getShopProductsFromJson(String str) =>
    GetShopProducts.fromJson(json.decode(str));

String getShopProductsToJson(GetShopProducts data) =>
    json.encode(data.toJson());

class GetShopProducts {
  final String? message;
  final List<ProductModel>? products;

  GetShopProducts({
    this.message,
    this.products,
  });

  factory GetShopProducts.fromJson(Map<String, dynamic> json) =>
      GetShopProducts(
        message: json["message"],
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(
                json["products"]!.map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class ProductModel {
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final List<String>? imagesUrls;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imagesUrls,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        imagesUrls: json["imagesUrls"] == null
            ? []
            : List<String>.from(json["imagesUrls"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "imagesUrls": imagesUrls == null
            ? []
            : List<dynamic>.from(imagesUrls!.map((x) => x)),
      };
}
