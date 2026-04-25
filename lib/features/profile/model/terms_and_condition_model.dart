// To parse this JSON data, do
//
//     final termConditionModel = termConditionModelFromJson(jsonString);

import 'dart:convert';

TermConditionModel termConditionModelFromJson(String str) =>
    TermConditionModel.fromJson(json.decode(str));

String termConditionModelToJson(TermConditionModel data) =>
    json.encode(data.toJson());

class TermConditionModel {
  final bool? success;
  final String? message;
  final Data? data;

  TermConditionModel({this.success, this.message, this.data});

  TermConditionModel copyWith({bool? success, String? message, Data? data}) =>
      TermConditionModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory TermConditionModel.fromJson(Map<String, dynamic> json) =>
      TermConditionModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? id;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({this.id, this.content, this.createdAt, this.updatedAt});

  Data copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Data(
    id: id ?? this.id,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    content: json["content"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
