import 'package:stepOut/data/config/mapper.dart';

class ItemsModel extends SingleMapper {
  String? message;
  List<ItemModel>? data;
  int? statusCode;

  ItemsModel({this.statusCode, this.message, this.data});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ItemModel.fromJson(v));
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
    return ItemsModel.fromJson(json);
  }
}

class ItemModel {
  int? id;
  String? image;
  String? title;
  String? price;
  String? discountPrice;
  String? discount;

  ItemModel(
      {this.id,
      this.image,
      this.title,
      this.discountPrice,
      this.price,
      this.discount});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    discountPrice = json['discount_price'];
    price = json['price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    data['discount_price'] = discountPrice;
    data['discount'] = discount;

    return data;
  }
}
