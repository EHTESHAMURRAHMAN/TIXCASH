// To parse this JSON data, do
//
//     final transferResponse = transferResponseFromJson(jsonString);

import 'dart:convert';

List<TransferResponse> transferResponseFromJson(String str) =>
    List<TransferResponse>.from(
        json.decode(str).map((x) => TransferResponse.fromJson(x)));

String transferResponseToJson(List<TransferResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferResponse {
  TransferResponse({
    required this.transactionDate,
    required this.credit,
    required this.debit,
    required this.commissionAmt,
    required this.currency,
    required this.paymentType,
    required this.fromAdress,
    required this.toAddress,
    required this.txthash,
    required this.remark,
  });

  final String transactionDate;
  final double credit;
  final double debit;
  final double commissionAmt;
  final String currency;
  final String paymentType;
  final String fromAdress;
  final String toAddress;
  final String txthash;
  final String remark;

  factory TransferResponse.fromJson(Map<String, dynamic> json) =>
      TransferResponse(
        transactionDate: json["transactionDate"] ?? '',
        credit: json["credit"].toDouble(),
        debit: json["debit"].toDouble(),
        commissionAmt: json["commissionAmt"].toDouble(),
        currency: json["currency"] ?? 'LINE',
        paymentType: json["paymentType"] ?? '',
        fromAdress: json["fromAdress"] ?? '',
        toAddress: json["toAddress"] ?? '',
        txthash: json["txthash"] ?? '',
        remark: json["remark"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "transactionDate": transactionDate,
        "credit": credit,
        "debit": debit,
        "commissionAmt": commissionAmt,
        "currency": currency,
        "paymentType": paymentType,
        "fromAdress": fromAdress,
        "toAddress": toAddress,
        "txthash": txthash,
        "remark": remark,
      };
}
