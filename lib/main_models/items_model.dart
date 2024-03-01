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
  int? id;
  int count = 1;
  String? image;
  String? name;
  String? size;
  double? price;
  double? discountPrice;
  double? discount;
  String? color;
  double get finalPrice => discountPrice != null ? discountPrice ?? 0 : price!;

  ItemModel(
      {this.id,
      this.count = 1,
      this.image,
      this.name,
      this.discountPrice,
      this.price,
      this.size,
      this.color,
      this.discount});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] is String ? int.parse(json['id']) : json['id'];
    count = json['count'] ?? 1;
    image = json['image'];
    name = json['name'];
    discountPrice = json['discount_price'] != null
        ? double.parse(json['discount_price'].toString())
        : null;
    price =
        json['price'] != null ? double.parse(json['price'].toString()) : null;
    discount = json['discount'] != null
        ? double.parse(json['discount'].toString())
        : null;
    size = json['size'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['count'] = count;
    data['image'] = image;
    data['name'] = name;
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
