import 'dart:convert';

List<LevelitemModel> levelitemModelFromJson(String str) =>
    List<LevelitemModel>.from(
        json.decode(str).map((x) => LevelitemModel.fromJson(x)));

String levelitemModelToJson(List<LevelitemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LevelitemModel {
  LevelitemModel({
    required this.invitationcode,
    required this.staking,
  });

  final String invitationcode;
  final String staking;

  factory LevelitemModel.fromJson(Map<String, dynamic> json) => LevelitemModel(
        invitationcode: json["invitationcode"],
        staking: json["staking"],
      );

  Map<String, dynamic> toJson() => {
        "invitationcode": invitationcode,
        "staking": staking,
      };
}
