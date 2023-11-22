// To parse this JSON data, do
//
//     final tokenDetail = tokenDetailFromJson(jsonString);

import 'dart:convert';

TokenDetail tokenDetailFromJson(String str) =>
    TokenDetail.fromJson(json.decode(str));

String tokenDetailToJson(TokenDetail data) => json.encode(data.toJson());

class TokenDetail {
  TokenDetail({
    required this.userid,
    required this.currencyname,
    required this.currencysymbol,
    required this.contractaddress,
    required this.decimals,
    required this.network,
    required this.active,
  });

  final int userid;
  final String currencyname;
  final String currencysymbol;
  final String contractaddress;
  final int decimals;
  final String network;
  final int active;

  factory TokenDetail.fromJson(Map<String, dynamic> json) => TokenDetail(
        userid: json["userid"],
        currencyname: json["currencyname"] ?? '',
        currencysymbol: json["currencysymbol"] ?? '',
        contractaddress: json["contractaddress"] ?? '',
        decimals: json["decimals"] ?? 0,
        network: json["network"] ?? '',
        active: json["active"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "currencyname": currencyname,
        "currencysymbol": currencysymbol,
        "contractaddress": contractaddress,
        "decimals": decimals,
        "network": network,
        "active": active,
      };
}
