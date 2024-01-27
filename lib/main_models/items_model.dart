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

class ItemModel extends LocaleSingleMapper {
  String? id;
  int count = 1;
  String? image;
  String? title;
  String? size;
  double? price;
  String? discountPrice;
  String? discount;
  String? color;

  ItemModel(
      {this.id,
      this.count = 1,
      this.image,
      this.title,
      this.discountPrice,
      this.price,
      this.size,
      this.color,
      this.discount});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    count = json['count'] ?? 1;
    image = json['image'];
    title = json['title'];
    discountPrice = json['discount_price'];
    price = json['price'];
    discount = json['discount'];
    size = json['size'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['count'] = count;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    // data['discount_price'] = discountPrice;
    data['color'] = color;
    data['size'] = size;
    // data['discount'] = discount;

    return data;
  }

  @override
  Mapper fromMapper(Map<String, dynamic> data) {
    return ItemModel.fromJson(data);
  }

  @override
  Map<String, dynamic> toMap() {
    return toJson();
  }
}
