// To parse this JSON data, do
//
//     final currencyListResponse = currencyListResponseFromJson(jsonString);

import 'package:get/get.dart';
import 'dart:convert';

List<CurrencyListResponse> currencyListResponseFromJson(String str) =>
    List<CurrencyListResponse>.from(
        json.decode(str).map((x) => CurrencyListResponse.fromJson(x)));

String currencyListResponseToJson(List<CurrencyListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrencyListResponse {
  CurrencyListResponse({
    required this.symbol,
    required this.icon,
    required this.currency,
    required this.active,
    required this.topcurrency,
  });

  final dynamic symbol;
  final String icon;
  final String currency;
  final RxBool active;
  final int topcurrency;

  factory CurrencyListResponse.fromJson(Map<String, dynamic> json) =>
      CurrencyListResponse(
        symbol: json["symbol"],
        icon: json["icon"],
        currency: json["currency"],
        topcurrency: json["topcurrency"],
        active: json["active"] == 1 ? true.obs : false.obs,
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "icon": icon,
        "currency": currency,
        "active": active,
        "topcurrency": topcurrency,
      };
}



// import 'package:get/get.dart';
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// List<CurrencyListResponse> currencyListResponseFromJson(String str) => List<CurrencyListResponse>.from(json.decode(str).map((x) => CurrencyListResponse.fromJson(x)));
//
// String currencyListResponseToJson(List<CurrencyListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class CurrencyListResponse {
//   CurrencyListResponse({
//     required this.currency,
//     required this.icon,
//     required this.selected,
//   });
//
//   final String currency;
//   final String icon;
//   RxBool selected;
//
//   factory CurrencyListResponse.fromJson(Map<String, dynamic> json) => CurrencyListResponse(
//     currency: json["currency"],
//     icon: json["icon"],
//     selected: false.obs
//   );
//
//   Map<String, dynamic> toJson() => {
//     "currency": currency,
//     "icon": icon,
//   };
// }
