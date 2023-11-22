import 'dart:convert';

List<ReferralClaimlistModel> referralClaimlistModelFromJson(String str) =>
    List<ReferralClaimlistModel>.from(
        json.decode(str).map((x) => ReferralClaimlistModel.fromJson(x)));

String referralClaimlistModelToJson(List<ReferralClaimlistModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReferralClaimlistModel {
  ReferralClaimlistModel({
    required this.amount,
    required this.gasfee,
    required this.transactiondate,
    required this.remark,
    required this.txthash,
    required this.status,
  });

  final double amount;
  final double gasfee;
  final String transactiondate;
  final String remark;
  final String txthash;
  final String status;

  factory ReferralClaimlistModel.fromJson(Map<String, dynamic> json) =>
      ReferralClaimlistModel(
        amount: json["amount"],
        gasfee: json["gasfee"],
        transactiondate: json["transactiondate"],
        remark: json["remark"],
        txthash: json["txthash"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "gasfee": gasfee,
        "transactiondate": transactiondate,
        "remark": remark,
        "txthash": txthash,
        "status": status,
      };
}
