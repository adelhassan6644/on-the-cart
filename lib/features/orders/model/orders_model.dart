import 'package:stepOut/data/config/mapper.dart';

class OrdersModel extends SingleMapper {
  String? message;
  List<MyOrderItem>? data;
  int? statusCode;

  OrdersModel({this.statusCode, this.message, this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <MyOrderItem>[];
      json['data'].forEach((v) {
        data!.add(MyOrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrdersModel.fromJson(json);
  }
}

class MyOrderItem {
  int? id;
  String? title;
  int? status;
  String? image;
  String? total;
  DateTime? createdAt;
  MyOrderItem(
      {this.id,
      this.image,
      this.total,
      this.createdAt,
      this.status,
      this.title});

  MyOrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    total = json['total'].toString();
    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['status'] = status;
    data['total'] = total;
    data['created_at'] = createdAt?.toIso8601String();

    return data;
  }
}

enum OrderStatus {
  preOrdered,
  ordered,
  processing,
  shipping,
  delivered,
  finished,
  canceled,
  returned
}
