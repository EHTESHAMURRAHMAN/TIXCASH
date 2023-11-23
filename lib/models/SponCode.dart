// To parse this JSON data, do
//
//     final SponCode = SponCodeFromJson(jsonString);

import 'dart:convert';

SponCode sponCodeFromJson(String str) => SponCode.fromJson(json.decode(str));

String sponCodeToJson(SponCode data) => json.encode(data.toJson());

class SponCode {
  SponCode({
    required this.sponsorcode,
  });

  final String sponsorcode;
  factory SponCode.fromJson(Map<String, dynamic> json) {
    return SponCode(
      sponsorcode: json["sponsorcode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "sponsorcode": sponsorcode,
      };
}
