import 'package:stepOut/data/config/mapper.dart';

class NotificationsModel extends SingleMapper {
  String? status;
  String? message;
  List<NotificationItem>? data;

  NotificationsModel({
    this.status,
    this.message,
    this.data,
  });

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null
        ? []
        : List<NotificationItem>.from(
            json["data"]!.map((x) => NotificationItem.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return NotificationsModel.fromJson(json);
  }
}

class NotificationItem {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  NotificationBody? notificationBody;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationItem({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.notificationBody,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        notificationBody: json["data"] == null
            ? null
            : NotificationBody.fromJson(json["data"]),
        isRead: json["read_at"] != null ? true : false,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": notificationBody?.toJson(),
        "read_at": isRead,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class NotificationBody {
  String? title;
  String? image;
  String? message;
  int? status;
  int? placeId;

  NotificationBody({
    this.title,
    this.message,
    this.image,
    this.status,
    this.placeId,
  });

  factory NotificationBody.fromJson(Map<String, dynamic> json) =>
      NotificationBody(
        title: json["title"],
        image: json["image"],
        message: json["message"],
        status: json["status"],
        placeId: json["place_id"].toString() != "null"
            ? int.parse(json["place_id"].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "status": status,
        "place_id": placeId,
      };
}
