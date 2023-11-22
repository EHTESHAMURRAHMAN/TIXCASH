// To parse this JSON data, do
//
//     final WhiteListResponse = WhiteListResponseFromJson(jsonString);

import 'dart:convert';

WhiteListResponse whiteListResponseFromJson(String str) =>
    WhiteListResponse.fromJson(json.decode(str));

String whiteListResponseToJson(WhiteListResponse data) =>
    json.encode(data.toJson());

class WhiteListResponse {
  WhiteListResponse({
    required this.whiteliststatus,
  });

  final int whiteliststatus;

  factory WhiteListResponse.fromJson(Map<String, dynamic> json) =>
      WhiteListResponse(
        whiteliststatus: json["whiteliststatus"],
      );

  Map<String, dynamic> toJson() => {
        "whiteliststatus": whiteliststatus,
      };
}
