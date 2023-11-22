import 'dart:convert';

List<StakeListModel> stakeListModelFromJson(String str) =>
    List<StakeListModel>.from(
        json.decode(str).map((x) => StakeListModel.fromJson(x)));

String stakeListModelToJson(List<StakeListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StakeListModel {
  StakeListModel({
    required this.totaldays,
    required this.staketype,
  });

  final String totaldays;
  final int staketype;

  factory StakeListModel.fromJson(Map<String, dynamic> json) => StakeListModel(
        totaldays: json["totaldays"],
        staketype: json["staketype"],
      );

  Map<String, dynamic> toJson() => {
        "totaldays": totaldays,
        "staketype": staketype,
      };
}
