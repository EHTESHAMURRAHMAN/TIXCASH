// To parse this JSON data, do
//
//     final marketResponse = marketResponseFromJson(jsonString);

import 'dart:convert';

List<MarketResponse> marketResponseFromJson(String str) =>
    List<MarketResponse>.from(
        json.decode(str).map((x) => MarketResponse.fromJson(x)));

String marketResponseToJson(List<MarketResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarketResponse {
  MarketResponse({
    required this.userid,
    required this.marketName,
    required this.marketLocation,
    required this.contact,
    required this.address,
    required this.shopLogo,
  });

  final int userid;
  final String marketName;
  final String marketLocation;
  final String contact;
  final String address;
  final String shopLogo;

  factory MarketResponse.fromJson(Map<String, dynamic> json) => MarketResponse(
        userid: json["userid"] ?? 1,
        marketName: json["marketName"],
        marketLocation: json["marketLocation"],
        contact: json["contact"],
        address: json["address"],
        shopLogo: json["shopLogo"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "marketName": marketName,
        "marketLocation": marketLocation,
        "contact": contact,
        "address": address,
        "shopLogo": shopLogo,
      };
}
