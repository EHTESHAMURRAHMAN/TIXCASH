import 'dart:convert';

WalletResponse walletResponseFromJson(String str) =>
    WalletResponse.fromJson(json.decode(str));

String walletResponseToJson(WalletResponse data) => json.encode(data.toJson());

class WalletResponse {
  WalletResponse({
    required this.id,
    required this.address,
    required this.password,
    required this.status,
  });

  final int id;
  final String address;
  final String password;
  final String status;

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
        id: json["id"],
        address: json["address"],
        password: json["password"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "password": password,
        "status": status,
      };
}
