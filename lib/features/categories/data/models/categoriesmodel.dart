// To parse this JSON data, do
//
//     final catiegoresModel = catiegoresModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CatiegoresModel catiegoresModelFromJson(String str) =>
    CatiegoresModel.fromJson(json.decode(str));

String catiegoresModelToJson(CatiegoresModel data) =>
    json.encode(data.toJson());

class CatiegoresModel {
  final String message;
  final List<JobCategory> jobCategories;

  CatiegoresModel({
    required this.message,
    required this.jobCategories,
  });

  factory CatiegoresModel.fromJson(Map<String, dynamic> json) =>
      CatiegoresModel(
        message: json["message"],
        jobCategories: List<JobCategory>.from(
            json["jobCategories"].map((x) => JobCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "jobCategories":
            List<dynamic>.from(jobCategories.map((x) => x.toJson())),
      };
}

class JobCategory {
  final String id;
  final String name;
  final String description;

  JobCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  factory JobCategory.fromJson(Map<String, dynamic> json) => JobCategory(
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
