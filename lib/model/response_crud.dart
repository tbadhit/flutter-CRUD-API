// To parse this JSON data, do
//
//     final ResponseCrud = ResponseCrudFromJson(jsonString);

import 'dart:convert';

ResponseCrud responseCrudFromJson(String str) =>
    ResponseCrud.fromJson(json.decode(str));

String responseCrudToJson(ResponseCrud data) => json.encode(data.toJson());

class ResponseCrud {
  ResponseCrud({
    required this.sukses,
    required this.pesan,
    this.lastId,
  });

  bool sukses;
  String pesan;
  int? lastId;

  factory ResponseCrud.fromJson(Map<String, dynamic> json) => ResponseCrud(
        sukses: json["sukses"],
        pesan: json["pesan"],
        lastId: json["last_id"],
      );

  Map<String, dynamic> toJson() => {
        "sukses": sukses,
        "pesan": pesan,
        "last_id": lastId,
      };
}
