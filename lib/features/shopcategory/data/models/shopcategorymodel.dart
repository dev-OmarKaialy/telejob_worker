// To parse this JSON data, do
//
//     final shopCategoryModel = shopCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ShopCategoryModel shopCategoryModelFromJson(String str) =>
    ShopCategoryModel.fromJson(json.decode(str));

String shopCategoryModelToJson(ShopCategoryModel data) =>
    json.encode(data.toJson());

class ShopCategoryModel {
  final String message;
  final List<ShopCategory> shopCategories;

  ShopCategoryModel({
    required this.message,
    required this.shopCategories,
  });

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) =>
      ShopCategoryModel(
        message: json["message"],
        shopCategories: List<ShopCategory>.from(
            json["shopCategories"].map((x) => ShopCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "shopCategories":
            List<dynamic>.from(shopCategories.map((x) => x.toJson())),
      };
}

class ShopCategory {
  final String id;
  final String name;
  final String description;

  ShopCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ShopCategory.fromJson(Map<String, dynamic> json) => ShopCategory(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}
