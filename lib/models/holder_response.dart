// To parse this JSON data, do
//
//     final holderResponse = holderResponseFromJson(jsonString);

import 'dart:convert';

List<HolderResponse> holderResponseFromJson(String str) =>
    List<HolderResponse>.from(
        json.decode(str).map((x) => HolderResponse.fromJson(x)));

String holderResponseToJson(List<HolderResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HolderResponse {
  HolderResponse({
    required this.rank,
    required this.address,
    required this.quantity,
    required this.percentage,
  });

  final String rank;
  final String address;
  final double quantity;
  final double percentage;

  factory HolderResponse.fromJson(Map<String, dynamic> json) => HolderResponse(
        rank: json["rank"],
        address: json["address"],
        quantity: json["quantity"].toDouble(),
        percentage: json["percentage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "address": address,
        "quantity": quantity,
        "percentage": percentage,
      };
}
