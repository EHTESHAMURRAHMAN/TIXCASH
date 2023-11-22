// To parse this JSON data, do
//
//     final infoResponse = infoResponseFromJson(jsonString);

import 'dart:convert';

InfoResponse infoResponseFromJson(String str) =>
    InfoResponse.fromJson(json.decode(str));

String infoResponseToJson(InfoResponse data) => json.encode(data.toJson());

class InfoResponse {
  InfoResponse({
    required this.overview,
    required this.tokenName,
    required this.maxTotalSupply,
    required this.holders,
    required this.internaltransfer,
    required this.externaltransfer,
    required this.contractAddress,
    required this.decimalValue,
  });

  final String overview;
  final String tokenName;
  final String maxTotalSupply;
  final String holders;
  final String internaltransfer;
  final String externaltransfer;
  final String contractAddress;
  final String decimalValue;

  factory InfoResponse.fromJson(Map<String, dynamic> json) => InfoResponse(
        overview: json["overview"],
        tokenName: json["tokenName"],
        maxTotalSupply: json["maxTotalSupply"],
        holders: json["holders"],
        internaltransfer: json["internaltransfer"],
        externaltransfer: json["externaltransfer"],
        contractAddress: json["contractAddress"],
        decimalValue: json["decimalValue"],
      );

  Map<String, dynamic> toJson() => {
        "overview": overview,
        "tokenName": tokenName,
        "maxTotalSupply": maxTotalSupply,
        "holders": holders,
        "internaltransfer": internaltransfer,
        "externaltransfer": externaltransfer,
        "contractAddress": contractAddress,
        "decimalValue": decimalValue,
      };
}
