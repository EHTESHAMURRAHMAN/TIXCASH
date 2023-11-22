import 'dart:convert';

WorldCurrencyResponse worldCurrencyResponseFromJson(String str) =>
    WorldCurrencyResponse.fromJson(json.decode(str));

String worldCurrencyResponseToJson(WorldCurrencyResponse data) =>
    json.encode(data.toJson());

class WorldCurrencyResponse {
  WorldCurrencyResponse({
    required this.data,
  });

  final WorldCurrency data;

  factory WorldCurrencyResponse.fromJson(Map<String, dynamic> json) =>
      WorldCurrencyResponse(
        data: WorldCurrency.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class WorldCurrency {
  WorldCurrency({
    required this.EUR,
    required this.CNY,
    required this.RUB,
    required this.JPY,
    required this.HKD,
    required this.GBP,
  });

  final double EUR;
  final double CNY;
  final double RUB;
  final double JPY;
  final double HKD;
  final double GBP;

  factory WorldCurrency.fromJson(Map<String, dynamic> json) => WorldCurrency(
        EUR: json["EUR"],
        CNY: json["CNY"],
        RUB: json["RUB"],
        JPY: json["JPY"],
        HKD: json["HKD"],
        GBP: json["GBP"],
      );

  Map<String, dynamic> toJson() => {
        "EUR": EUR,
        "CNY": CNY,
        "RUB": RUB,
        "JPY": JPY,
        "HKD": HKD,
        "GBP": GBP,
      };
}
