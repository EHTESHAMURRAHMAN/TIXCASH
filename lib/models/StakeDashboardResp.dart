// To parse this JSON data, do
//
//     final StakeDashboardResponse = StakeDashboardResponseFromJson(jsonString);
import 'dart:convert';

StakeDashboardResponse stakeDashboardResponseFromJson(String str) =>
    StakeDashboardResponse.fromJson(json.decode(str));

String stakeDashboardResponseToJson(StakeDashboardResponse data) =>
    json.encode(data.toJson());

class StakeDashboardResponse {
  StakeDashboardResponse({
    required this.totalstaked,
    required this.totalreward,
    required this.totalincome,
    required this.pendingreward,
    required this.dailyreward,
    required this.stakingdays,
    required this.stakingstart,
    required this.stakingend,
    required this.userstakindate,
    required this.totalsincome,
    required this.stakedamt,
    required this.remain,
    required this.paid,
    required this.unclaim,
    required this.apy,
    required this.userclaimdate,
  });

  final double totalstaked;
  final double totalreward;
  final double totalincome;
  final double pendingreward;
  final double dailyreward;
  final String stakingdays;
  final String stakingstart;
  final String stakingend;
  final String userstakindate;
  final double totalsincome;
  final double stakedamt;
  final double remain;
  final int paid;
  final double unclaim;
  final double apy;
  final String userclaimdate;

  factory StakeDashboardResponse.fromJson(Map<String, dynamic> json) =>
      StakeDashboardResponse(
        totalstaked: json["totalstaked"],
        totalreward: json["totalreward"],
        totalincome: json["totalincome"],
        pendingreward: json["pendingreward"],
        dailyreward: json["dailyreward"],
        stakingdays: json["stakingdays"],
        stakingstart: json["stakingstart"].toString(),
        stakingend: json["stakingend"].toString(),
        userstakindate: json["userstakindate"],
        totalsincome: json["totalsincome"],
        stakedamt: json["stakedamt"],
        remain: json["remain"],
        paid: json["paid"],
        unclaim: json["unclaim"],
        apy: json["apy"],
        userclaimdate: json["userclaimdate"] ?? "2095-12-05 00:45:00",
      );

  Map<String, dynamic> toJson() => {
        "totalstaked": totalstaked,
        "totalreward": totalreward,
        "totalincome": totalincome,
        "pendingreward": pendingreward,
        "dailyreward": dailyreward,
        "stakingdays": stakingdays,
        "stakingstart": stakingstart,
        "stakingend": stakingend,
        "userstakindate": userstakindate,
        "totalsincome": totalsincome,
        "stakedamt": stakedamt,
        "remain": remain,
        "paid": paid,
        "unclaim": unclaim,
        "apy": apy,
        "userclaimdate": userclaimdate,
      };
}
