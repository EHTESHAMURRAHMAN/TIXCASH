// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);
import 'dart:convert';

List<UserResponse> userResponseFromJson(String str) => List<UserResponse>.from(
    json.decode(str).map((x) => UserResponse.fromJson(x)));

String userResponseToJson(List<UserResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

UserResponse userFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.id,
    required this.address,
    required this.privateKey,
    required this.status,
    required this.name,
    required this.password,
    required this.active,
    required this.message,
    required this.parentid,
  });

  final int id;
  final String address;
  final String privateKey;
  final String status;
  String name;
  String password;
  bool active;
  String message;
  int parentid;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        address: json["address"],
        privateKey: json["privateKey"] ?? '',
        status: json["status"],
        name: json["name"] ?? 'Account ${json["id"]}',
        password: json["password"],
        active: json["active"] ?? false,
        message: json["message"],
        parentid: json["parentid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "privateKey": privateKey,
        "status": status,
        "name": name,
        "password": password,
        "active": active,
        "message": message,
        "parentid": parentid,
      };
}

/*

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.id,
    required this.address,
    required this.privateKey,
    required this.status,
    required this.password,
    required this.active,
  });

  final int id;
  final String address;
  final String privateKey;
  final String status;
   String password;
   bool active;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    id: json["id"],
    address: json["address"],
    privateKey: json["privateKey"]??'',
    status: json["status"],
    password: json["password"],
    active: json["active"]??true,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "privateKey": privateKey,
    "status": status,
    "password": password,
    "active": active,
  };
}
*/
// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);
/*import 'dart:convert';

List<UserResponse> userResponseFromJson(String str) => List<UserResponse>.from(
    json.decode(str).map((x) => UserResponse.fromJson(x)));

String userResponseToJson(List<UserResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

UserResponse userFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.id,
    required this.pid,
    required this.address,
    required this.privateKey,
    required this.status,
    required this.name,
    required this.password,
    required this.active,
  });

  final int id;
  final int pid;
  final String address;
  final String privateKey;
  final String status;
  String name;
  String password;
  bool active;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        pid: json["pid"],
        address: json["address"],
        privateKey: json["privateKey"] ?? '',
        status: json["status"],
        name: json["name"] ?? 'Account ${json["id"]}',
        password: json["password"],
        active: json["active"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pid": pid,
        "address": address,
        "privateKey": privateKey,
        "status": status,
        "name": name,
        "password": password,
        "active": active,
      };
}*/

/*

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.id,
    required this.address,
    required this.privateKey,
    required this.status,
    required this.password,
    required this.active,
  });

  final int id;
  final String address;
  final String privateKey;
  final String status;
   String password;
   bool active;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    id: json["id"],
    address: json["address"],
    privateKey: json["privateKey"]??'',
    status: json["status"],
    password: json["password"],
    active: json["active"]??true,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "privateKey": privateKey,
    "status": status,
    "password": password,
    "active": active,
  };
}
*/
