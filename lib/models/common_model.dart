// To parse this JSON data, do
//
//     final commonResponse = commonResponseFromJson(jsonString);

import 'package:flutter/material.dart';
import 'dart:convert';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  CommonResponse({
    required this.status,
    required this.message,
  });

  final String status;
  final String message;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

class SuffixWidget {
  final Widget primary;
  final Widget secondary;

  SuffixWidget(
      {required this.primary,
      this.secondary = const Icon(
        Icons.check,
        color: Color(0xFF1680ee),
      )});
}

// class FieldData{
//   final String data;
//   final bool valid;
//   FieldData({required this.data, required this.valid});
// }

class PopupItem {
  final String title;
  final String value;

  PopupItem({required this.title, required this.value});
}
