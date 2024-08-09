// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final String message;
  final Worker worker;

  ProfileModel({
    required this.message,
    required this.worker,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        message: json["message"],
        worker: Worker.fromJson(json["worker"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "worker": worker.toJson(),
      };
}

class Worker {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String description;
  final List<JobCategory> jobCategories;

  Worker({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.description,
    required this.jobCategories,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        description: json["description"],
        jobCategories: List<JobCategory>.from(
            json["JobCategories"].map((x) => JobCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "description": description,
        "JobCategories":
            List<dynamic>.from(jobCategories.map((x) => x.toJson())),
      };
}

class JobCategory {
  final String id;
  final String name;

  JobCategory({
    required this.id,
    required this.name,
  });

  factory JobCategory.fromJson(Map<String, dynamic> json) => JobCategory(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
