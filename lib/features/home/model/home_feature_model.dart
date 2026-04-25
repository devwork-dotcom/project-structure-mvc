// To parse this JSON data, do
//
//     final homeFeatureModel = homeFeatureModelFromJson(jsonString);

import 'dart:convert';

HomeFeatureModel homeFeatureModelFromJson(String str) =>
    HomeFeatureModel.fromJson(json.decode(str));

String homeFeatureModelToJson(HomeFeatureModel data) =>
    json.encode(data.toJson());

class HomeFeatureModel {
  final bool? success;
  final String? message;
  final Data? data;

  HomeFeatureModel({this.success, this.message, this.data});

  HomeFeatureModel copyWith({bool? success, String? message, Data? data}) =>
      HomeFeatureModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory HomeFeatureModel.fromJson(Map<String, dynamic> json) =>
      HomeFeatureModel(
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
  final String? title;
  final String? reference;
  final String? description;
  final int? waterComplete;
  final int? waterOutOfContext;
  final int? mealComplete;
  final int? mealOutOfContext;
  final int? workOutComplete;
  final int? streakComplete;

  Data({
    this.title,
    this.reference,
    this.description,
    this.waterComplete,
    this.waterOutOfContext,
    this.mealComplete,
    this.mealOutOfContext,
    this.workOutComplete,
    this.streakComplete,
  });

  Data copyWith({
    String? title,
    String? reference,
    String? description,
    int? waterComplete,
    int? waterOutOfContext,
    int? mealComplete,
    int? mealOutOfContext,
    int? workOutComplete,
    int? streakComplete,
  }) => Data(
    title: title ?? this.title,
    reference: reference ?? this.reference,
    description: description ?? this.description,
    waterComplete: waterComplete ?? this.waterComplete,
    waterOutOfContext: waterOutOfContext ?? this.waterOutOfContext,
    mealComplete: mealComplete ?? this.mealComplete,
    mealOutOfContext: mealOutOfContext ?? this.mealOutOfContext,
    workOutComplete: workOutComplete ?? this.workOutComplete,
    streakComplete: streakComplete ?? this.streakComplete,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    reference: json["reference"],
    description: json["description"],
    waterComplete: json["waterComplete"],
    waterOutOfContext: json["waterOutOfContext"],
    mealComplete: json["mealComplete"],
    mealOutOfContext: json["mealOutOfContext"],
    workOutComplete: json["workOutComplete"],
    streakComplete: json["streakComplete"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "reference": reference,
    "description": description,
    "waterComplete": waterComplete,
    "waterOutOfContext": waterOutOfContext,
    "mealComplete": mealComplete,
    "mealOutOfContext": mealOutOfContext,
    "workOutComplete": workOutComplete,
    "streakComplete": streakComplete,
  };
}
