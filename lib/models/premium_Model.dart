import 'dart:convert';

List<PremiumModel> premiumModelFromJson(String str) => List<PremiumModel>.from(
    json.decode(str).map((x) => PremiumModel.fromJson(x)));

String premiumModelToJson(List<PremiumModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PremiumModel {
  PremiumModel({
    required this.pid,
    required this.price,
    required this.packagename,
  });

  final int pid;
  final double price;
  final String packagename;

  factory PremiumModel.fromJson(Map<String, dynamic> json) => PremiumModel(
        pid: json["pid"],
        price: json["price"],
        packagename: json["packagename"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "price": price,
        "packagename": packagename,
      };
}



// import 'dart:convert';
//
// List<PremiumModel> PremiumModelFromJson(String str) => List<PremiumModel>.from(json.decode(str).map((x) => PremiumModel.fromJson(x)));
//
// String PremiumModelToJson(List<PremiumModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class PremiumModel {
//   PremiumModel({
//     required this.currency,
//     required this.balance,
//     required this.icon,
//   });
//
//   final String currency;
//   final double balance;
//   final String icon;
//
//   factory PremiumModel.fromJson(Map<String, dynamic> json) => PremiumModel(
//     currency: json["currency"],
//     balance: json["balance"],
//     icon: json["icon"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "currency": currency,
//     "balance": balance,
//     "icon": icon,
//   };
// }
