import 'dart:convert';

List<LevelitemModel> levelitemModelFromJson(String str) =>
    List<LevelitemModel>.from(
        json.decode(str).map((x) => LevelitemModel.fromJson(x)));

String levelitemModelToJson(List<LevelitemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LevelitemModel {
  LevelitemModel({
    required this.invitationcode,
  });

  final String invitationcode;

  factory LevelitemModel.fromJson(Map<String, dynamic> json) => LevelitemModel(
        invitationcode: json["invitationcode"],
      );

  Map<String, dynamic> toJson() => {
        "invitationcode": invitationcode,
      };
}
