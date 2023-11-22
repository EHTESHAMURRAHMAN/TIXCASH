import 'dart:convert';

List<ReferalIncomeModel> referalIncomeModelFromJson(String str) =>
    List<ReferalIncomeModel>.from(json.decode(str).map((x) => ReferalIncomeModel.fromJson(x)));

String referalIncomeModelToJson(List<ReferalIncomeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReferalIncomeModel {
  ReferalIncomeModel({
    required this.amount,
    required this.transactiondate,
    required this.remark,
    required this.staking,
  });

  final double amount;
  final String transactiondate;
  final String remark;
  final String staking;

  factory ReferalIncomeModel.fromJson(Map<String, dynamic> json) => ReferalIncomeModel(
        amount: json["amount"],
        transactiondate: json["transactiondate"],
        remark: json["remark"],
        staking: json["staking"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "transactiondate": transactiondate,
        "remark": remark,
        "staking": staking,
      };
}
