// To parse this JSON data, do
//
//     final UsercodeResponse = UsercodeResponseFromJson(jsonString);

import 'dart:convert';

UsercodeResponse usercodeResponseFromJson(String str) =>
    UsercodeResponse.fromJson(json.decode(str));

String usercodeResponseToJson(UsercodeResponse data) =>
    json.encode(data.toJson());

class UsercodeResponse {
  UsercodeResponse({
    required this.refrellcode,
  });

  final String refrellcode;

  factory UsercodeResponse.fromJson(Map<String, dynamic> json) =>
      UsercodeResponse(
        refrellcode: json["refrellcode"],
      );

  Map<String, dynamic> toJson() => {
        "refrellcode": refrellcode,
      };
}
