// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final bool? success;
  final String? message;
  final Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel copyWith({bool? success, String? message, Data? data}) =>
      ProfileModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  final String? name;
  final String? email;
  final String? profileImage;
  final int? age;
  final String? gender;
  final int? height;
  final int? weight;
  final String? activityLevel;
  final String? goal;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.activityLevel,
    this.goal,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  Data copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    int? age,
    String? gender,
    int? height,
    int? weight,
    String? activityLevel,
    String? goal,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Data(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    profileImage: profileImage ?? this.profileImage,
    age: age ?? this.age,
    gender: gender ?? this.gender,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    activityLevel: activityLevel ?? this.activityLevel,
    goal: goal ?? this.goal,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    profileImage: json["profileImage"],
    age: json["age"],
    gender: json["gender"],
    height: json["height"],
    weight: json["weight"],
    activityLevel: json["activityLevel"],
    goal: json["goal"],
    role: json["role"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "profileImage": profileImage,
    "age": age,
    "gender": gender,
    "height": height,
    "weight": weight,
    "activityLevel": activityLevel,
    "goal": goal,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
