import 'package:stepOut/data/config/mapper.dart';

import '../../../main_models/base_model.dart';

class StoresModel extends SingleMapper {
  String? message;
  List<StoreItem>? data;
  int? statusCode;

  StoresModel({this.statusCode, this.message, this.data});

  StoresModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <StoreItem>[];
      json['data'].forEach((v) {
        data!.add(StoreItem.fromJson(v));
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
    return StoresModel.fromJson(json);
  }
}

class StoreItem extends BaseModel {
  StoreItem({super.id, super.isStore = true, super.image, super.title = "Store Title"});

  StoreItem.fromJson(Map<String, dynamic> json) {
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
