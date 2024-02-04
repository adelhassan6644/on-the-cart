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
  String? image;
  bool? isStore;
  MyOrderItem({this.id, this.isStore = true, this.image, this.title});

  MyOrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    isStore = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['is_store'] = isStore;

    return data;
  }
}
