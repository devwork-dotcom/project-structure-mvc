// To parse this JSON data, do
//
//     final notificationSingleModel = notificationSingleModelFromJson(jsonString);

import 'dart:convert';

NotificationSingleModel notificationSingleModelFromJson(String str) =>
    NotificationSingleModel.fromJson(json.decode(str));

String notificationSingleModelToJson(NotificationSingleModel data) =>
    json.encode(data.toJson());

class NotificationSingleModel {
  final bool? success;
  final String? message;
  final Data? data;

  NotificationSingleModel({this.success, this.message, this.data});

  NotificationSingleModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) => NotificationSingleModel(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory NotificationSingleModel.fromJson(Map<String, dynamic> json) =>
      NotificationSingleModel(
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
  final String? receiverId;
  final String? senderId;
  final String? title;
  final String? body;
  final String? commentId;
  final String? replyCommentId;
  final String? groupBuyId;
  final String? learnId;
  final String? openChatId;
  final bool? read;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.receiverId,
    this.senderId,
    this.title,
    this.body,
    this.commentId,
    this.replyCommentId,
    this.groupBuyId,
    this.learnId,
    this.openChatId,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  Data copyWith({
    String? id,
    String? receiverId,
    String? senderId,
    String? title,
    String? body,
    String? commentId,
    String? replyCommentId,
    String? groupBuyId,
    String? learnId,
    String? openChatId,
    bool? read,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Data(
    id: id ?? this.id,
    receiverId: receiverId ?? this.receiverId,
    senderId: senderId ?? this.senderId,
    title: title ?? this.title,
    body: body ?? this.body,
    commentId: commentId ?? this.commentId,
    replyCommentId: replyCommentId ?? this.replyCommentId,
    groupBuyId: groupBuyId ?? this.groupBuyId,
    learnId: learnId ?? this.learnId,
    openChatId: openChatId ?? this.openChatId,
    read: read ?? this.read,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    receiverId: json["receiverId"],
    senderId: json["senderId"],
    title: json["title"],
    body: json["body"],
    commentId: json["commentId"],
    replyCommentId: json["replyCommentId"],
    groupBuyId: json["groupBuyId"],
    learnId: json["learnId"],
    openChatId: json["openChatId"],
    read: json["read"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "receiverId": receiverId,
    "senderId": senderId,
    "title": title,
    "body": body,
    "commentId": commentId,
    "replyCommentId": replyCommentId,
    "groupBuyId": groupBuyId,
    "learnId": learnId,
    "openChatId": openChatId,
    "read": read,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
