// To parse this JSON data, do
//
//     final joprequests = joprequestsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Joprequests joprequestsFromJson(String str) =>
    Joprequests.fromJson(json.decode(str));

String joprequestsToJson(Joprequests data) => json.encode(data.toJson());

class Joprequests {
  final String message;
  final List<Request> requests;

  Joprequests({
    required this.message,
    required this.requests,
  });

  factory Joprequests.fromJson(Map<String, dynamic> json) => Joprequests(
        message: json["message"],
        requests: List<Request>.from(
            json["requests"].map((x) => Request.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "requests": List<dynamic>.from(requests.map((x) => x.toJson())),
      };
}

class Request {
  final String id;
  final Customer customer;
  final String jobDescription;
  final String status;
  final List<Customer> jobCategories;

  Request({
    required this.id,
    required this.customer,
    required this.jobDescription,
    required this.status,
    required this.jobCategories,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["_id"],
        customer: Customer.fromJson(json["customer"]),
        jobDescription: json["jobDescription"],
        status: json["status"],
        jobCategories: List<Customer>.from(
            json["JobCategories"].map((x) => Customer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customer": customer.toJson(),
        "jobDescription": jobDescription,
        "status": status,
        "JobCategories":
            List<dynamic>.from(jobCategories.map((x) => x.toJson())),
      };
}

class Customer {
  final String id;
  final String name;

  Customer({
    required this.id,
    required this.name,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
