import 'dart:convert';

List<WalletListResp> walletListRespFromJson(String str) =>
    List<WalletListResp>.from(
        json.decode(str).map((x) => WalletListResp.fromJson(x)));

String walletListRespToJson(List<WalletListResp> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalletListResp {
  WalletListResp({
    required this.id,
    required this.parentid,
    required this.accountname,
    required this.address,
  });

  final int id;
  final int parentid;
  final String accountname;
  final String address;

  factory WalletListResp.fromJson(Map<String, dynamic> json) => WalletListResp(
        id: json["id"],
        parentid: json["parentid"],
        accountname: json["accountname"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentid": parentid,
        "accountname": accountname,
        "address": address,
      };
}
