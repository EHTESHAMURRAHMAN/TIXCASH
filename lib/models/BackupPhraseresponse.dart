import 'dart:convert';

BackupPResponse backupPResponseFromJson(String str) =>
    BackupPResponse.fromJson(json.decode(str));

String backupPResponseToJson(BackupPResponse data) =>
    json.encode(data.toJson());

class BackupPResponse {
  BackupPResponse({
    required this.backuphrase,
  });

  final String backuphrase;

  factory BackupPResponse.fromJson(Map<String, dynamic> json) =>
      BackupPResponse(
        backuphrase: json["backuphrase"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "backuphrase": backuphrase,
      };
}
