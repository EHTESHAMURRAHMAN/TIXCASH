import 'dart:convert';

List<StakingListHistoryModel> stakingListHistoryModelFromJson(String str) =>
    List<StakingListHistoryModel>.from(
        json.decode(str).map((x) => StakingListHistoryModel.fromJson(x)));

String stakingListHistoryModelToJson(List<StakingListHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StakingListHistoryModel {
  StakingListHistoryModel({
    required this.amount,
    required this.gasfee,
    required this.transactiondate,
    required this.remark,
    required this.txthash,
    required this.status,
    required this.staking,
  });

  final double amount;
  final double gasfee;
  final String transactiondate;
  final String remark;
  final String txthash;
  final String status;

  final String staking;

  factory StakingListHistoryModel.fromJson(Map<String, dynamic> json) =>
      StakingListHistoryModel(
        amount: json["amount"],
        gasfee: json["gasfee"],
        transactiondate: json["transactiondate"],
        remark: json["remark"],
        txthash: json["txthash"],
        status: json["status"],
        staking: json["staking"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "gasfee": gasfee,
        "transactiondate": transactiondate,
        "remark": remark,
        "txthash": txthash,
        "status": status,
        "staking": staking,
      };
}
