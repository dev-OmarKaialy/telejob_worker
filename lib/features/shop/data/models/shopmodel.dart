// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  final String message;
  final List<Shop> shops;

  ShopModel({
    required this.message,
    required this.shops,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        message: json["message"],
        shops: List<Shop>.from(json["shops"].map((x) => Shop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "shops": List<dynamic>.from(shops.map((x) => x.toJson())),
      };
}

class Shop {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String photoUrl;

  Shop({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.photoUrl,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "photoUrl": photoUrl,
      };
}
