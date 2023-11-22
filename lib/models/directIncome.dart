
// To parse this JSON data, do
//
//     final DirectincomeModel = DirectincomeModelFromJson(jsonString);

import 'dart:convert';

DirectincomeModel directincomeModelFromJson(String str) =>
    DirectincomeModel.fromJson(json.decode(str));

String directincomeModelToJson(DirectincomeModel data) =>
    json.encode(data.toJson());

class DirectincomeModel {
  DirectincomeModel({
    required this.claimamount,
     required this.totalamount,
  });

  final double claimamount;
  final double totalamount;

  factory DirectincomeModel.fromJson(Map<String, dynamic> json) =>
      DirectincomeModel(
       claimamount: json["claimamount"],
        totalamount: json["totalamount"],

      );

  Map<String, dynamic> toJson() => {
         "claimamount": claimamount,
          "totalamount": totalamount,
      };
}
