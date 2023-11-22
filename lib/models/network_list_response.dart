import 'dart:convert';

List<NetworkListResponse> networkListResponseFromJson(String str) => List<NetworkListResponse>.from(json.decode(str).map((x) => NetworkListResponse.fromJson(x)));

String networkListResponseToJson(List<NetworkListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NetworkListResponse {
  NetworkListResponse({
    required this.network,
  });

  final String network;

  factory NetworkListResponse.fromJson(Map<String, dynamic> json) => NetworkListResponse(
    network: json["network"],
  );

  Map<String, dynamic> toJson() => {
    "network": network,
  };
}
