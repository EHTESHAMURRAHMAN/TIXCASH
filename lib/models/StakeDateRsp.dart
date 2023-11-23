// To parse this JSON data, do
//
//     final StakedateResponse = StakedateResponseFromJson(jsonString);

import 'dart:convert';

StakedateResponse stakedateResponseFromJson(String str) =>
    StakedateResponse.fromJson(json.decode(str));

String stakedateResponseToJson(StakedateResponse data) =>
    json.encode(data.toJson());

class StakedateResponse {
  StakedateResponse({
    required this.stardate,
    required this.enddate,
    required this.currentdate,
  });

  final String stardate;
  final String enddate;
  final String currentdate;

  factory StakedateResponse.fromJson(Map<String, dynamic> json) {
    return StakedateResponse(
      stardate: json["stardate"],
      enddate: json["enddate"],
      currentdate: json["currentdate"],
    );
  }
  Map<String, dynamic> toJson() => {
        "stardate": stardate,
        "enddate": enddate,
        "currentdate": currentdate,
      };
}
