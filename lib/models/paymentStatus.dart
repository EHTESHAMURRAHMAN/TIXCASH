// To parse this JSON data, do
//
//     final PaymentStatusResponse = PaymentStatusResponseFromJson(jsonString);

import 'dart:convert';

PaymentStatusResponse paymentStatusResponseFromJson(String str) =>
    PaymentStatusResponse.fromJson(json.decode(str));

String paymentStatusResponseToJson(PaymentStatusResponse data) =>
    json.encode(data.toJson());

class PaymentStatusResponse {
  PaymentStatusResponse({
    required this.paymentid,
  });

  final int paymentid;

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) =>
      PaymentStatusResponse(
        paymentid: json["paymentid"],
      );

  Map<String, dynamic> toJson() => {
        "paymentid": paymentid,
      };
}
