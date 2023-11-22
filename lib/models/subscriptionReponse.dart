// To parse this JSON data, do
//
//     final SubscriptionResponse = SubscriptionResponseFromJson(jsonString);

import 'dart:convert';

SubscriptionResponse subscriptionResponseFromJson(String str) =>
    SubscriptionResponse.fromJson(json.decode(str));

String subscriptionResponseToJson(SubscriptionResponse data) =>
    json.encode(data.toJson());

class SubscriptionResponse {
  SubscriptionResponse({
    required this.pid,
  });

  final int pid;

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      SubscriptionResponse(
        pid: json["pid"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
      };
}
