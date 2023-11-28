// To parse this JSON data, do
//
//     final swapCurrency = swapCurrencyFromJson(jsonString);

import 'dart:convert';

List<SwapCurrency> swapCurrencyFromJson(String str) => List<SwapCurrency>.from(
    json.decode(str).map((x) => SwapCurrency.fromJson(x)));

String swapCurrencyToJson(List<SwapCurrency> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwapCurrency {
  SwapCurrency({
    required this.currency,
    required this.icon,
  });

  final String currency;
  final String icon;

  factory SwapCurrency.fromJson(Map<String, dynamic> json) => SwapCurrency(
        currency: json["currency"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "icon": icon,
      };

  void sort(Function(dynamic a, dynamic b) param0) {}
}
