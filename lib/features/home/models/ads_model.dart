import 'package:stepOut/data/config/mapper.dart';

class AdsModel extends SingleMapper {
  String? message;
  List<AdsItem>? data;

  AdsModel({this.message, this.data});

  AdsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <AdsItem>[];
      json['data'].forEach((v) {
        data!.add(AdsItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return AdsModel.fromJson(json);
  }
}

class AdsItem {
  int? id;
  int? itemId;
  String? image;
  String? name;
  String? status;

  AdsItem({this.id, this.status, this.itemId, this.image, this.name});

  AdsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    itemId = json['place_id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['item_id'] = itemId;
    data['image'] = image;
    data['name'] = name;

    return data;
  }
}
