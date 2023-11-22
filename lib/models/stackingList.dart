import 'dart:convert';

List<StakingListModel> stakingListModelFromJson(String str) =>
    List<StakingListModel>.from(
        json.decode(str).map((x) => StakingListModel.fromJson(x)));

String stakingListModelToJson(List<StakingListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StakingListModel {
  StakingListModel({
    required this.stakeamount,
    required this.remainingamt,
    required this.stakeid,
    required this.stake_date,
    required this.end_date,
    required this.stakeday,
    required this.paid_Days,
    required this.stakingincome,
    required this.apy,
  });

  final double stakeamount;
  final double remainingamt;
  final int stakeid;
  final String stake_date;
  final String end_date;
  final String stakeday;
  final String paid_Days;
  final double stakingincome;
  final double apy;

  factory StakingListModel.fromJson(Map<String, dynamic> json) =>
      StakingListModel(
        stakeamount: json["stakeamount"],
        remainingamt: json["remainingamt"],
        stakeid: json["stakeid"],
        stake_date: json["stake_date"],
        end_date: json["end_date"],
        stakeday: json["stakeday"],
        paid_Days: json["paid_Days"],
        stakingincome: json["stakingincome"],
        apy: json["apy"],
      );

  Map<String, dynamic> toJson() => {
        "stakeamount": stakeamount,
        "remainingamt": remainingamt,
        "stakeid": stakeid,
        "stake_date": stake_date,
        "end_date": end_date,
        "stakeday": stakeday,
        "paid_Days": paid_Days,
        "stakingincome": stakingincome,
        "apy": apy,
      };
}
