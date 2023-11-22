import 'dart:convert';

CurrencyRate currencyRateFromJson(String str) => CurrencyRate.fromJson(json.decode(str));

String currencyRateToJson(CurrencyRate data) => json.encode(data.toJson());

class CurrencyRate {
  CurrencyRate({
    required this.fromcurrency,
    required this.tocurrency,
    required this.price,
  });

  final String fromcurrency;
  final String tocurrency;
  final double price;

  factory CurrencyRate.fromJson(Map<String, dynamic> json) => CurrencyRate(
    fromcurrency: json["fromcurrency"],
    tocurrency: json["tocurrency"],
    price: json["price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "fromcurrency": fromcurrency,
    "tocurrency": tocurrency,
    "price": price,
  };
}
