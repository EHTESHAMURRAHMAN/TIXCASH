// To parse this JSON data, do
//
//     final transactionListResponse = transactionListResponseFromJson(jsonString);

import 'dart:convert';

List<TransactionListResponse> transactionListResponseFromJson(String str) =>
    List<TransactionListResponse>.from(
        json.decode(str).map((x) => TransactionListResponse.fromJson(x)));

String transactionListResponseToJson(List<TransactionListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionListResponse {
  TransactionListResponse({
    required this.transactionDate,
    required this.credit,
    required this.debit,
    required this.currency,
    required this.paymentType,
    required this.fromAdress,
    required this.toAddress,
    required this.txthash,
    required this.remark,
    required this.blockchaintitle,
  });

  final String transactionDate;
  final double credit;
  final double debit;
  final String currency;
  final String paymentType;
  final String fromAdress;
  final String toAddress;
  final String txthash;
  final String remark;
  final String blockchaintitle;

  factory TransactionListResponse.fromJson(Map<String, dynamic> json) =>
      TransactionListResponse(
        transactionDate: json["transactionDate"],
        credit: json["credit"].toDouble(),
        debit: json["debit"].toDouble(),
        currency: json["currency"] ?? '',
        paymentType: json["paymentType"] ?? '',
        fromAdress: json["fromAdress"] ?? '',
        toAddress: json["toAddress"] ?? '',
        txthash: json["txthash"] ?? '',
        remark: json["remark"] ?? '',
        blockchaintitle: json["blockchaintitle"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "transactionDate": transactionDate,
        "credit": credit,
        "debit": debit,
        "currency": currency,
        "paymentType": paymentType,
        "fromAdress": fromAdress,
        "toAddress": toAddress,
        "txthash": txthash,
        "remark": remark,
        "blockchaintitle": blockchaintitle,
      };
}
