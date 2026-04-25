// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  final bool? success;
  final String? message;
  final List<Datum>? data;

  NotificationsModel({this.success, this.message, this.data});

  NotificationsModel copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
  }) => NotificationsModel(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
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
  final String? announcementId;
  final bool? read;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
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
    this.announcementId,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
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
    String? announcementId,
    bool? read,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Datum(
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
    announcementId: announcementId ?? this.announcementId,
    read: read ?? this.read,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    announcementId: json["announcementId"],
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
    "announcementId": announcementId,
    "read": read,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
