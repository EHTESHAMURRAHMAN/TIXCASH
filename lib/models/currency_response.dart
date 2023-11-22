import 'dart:convert';

List<CurrencyResponse> currencyResponseFromJson(String str) =>
    List<CurrencyResponse>.from(
        json.decode(str).map((x) => CurrencyResponse.fromJson(x)));

String currencyResponseToJson(List<CurrencyResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrencyResponse {
  CurrencyResponse({
    required this.userid,
    required this.currency,
    required this.balance,
    required this.usdvalue,
    required this.price,
    required this.icon,
    required this.address,
  });

  final int userid;
  final String currency;
  final double balance;
  final double usdvalue;
  final double price;
  final String icon;
  final String address;

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) =>
      CurrencyResponse(
        userid: json["userid"],
        currency: json["currency"],
        balance: json["balance"].toDouble(),
        usdvalue: json["usdvalue"].toDouble(),
        price: json["price"].toDouble(),
        icon: json["icon"],
        address: json["address"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "currency": currency,
        "balance": balance,
        "usdvalue": usdvalue,
        "price": price,
        "icon": icon,
        "address": address,
      };
}



// import 'dart:convert';
//
// List<CurrencyResponse> currencyResponseFromJson(String str) => List<CurrencyResponse>.from(json.decode(str).map((x) => CurrencyResponse.fromJson(x)));
//
// String currencyResponseToJson(List<CurrencyResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class CurrencyResponse {
//   CurrencyResponse({
//     required this.currency,
//     required this.balance,
//     required this.icon,
//   });
//
//   final String currency;
//   final double balance;
//   final String icon;
//
//   factory CurrencyResponse.fromJson(Map<String, dynamic> json) => CurrencyResponse(
//     currency: json["currency"],
//     balance: json["balance"],
//     icon: json["icon"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "currency": currency,
//     "balance": balance,
//     "icon": icon,
//   };
// }
