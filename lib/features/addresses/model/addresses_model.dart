import 'package:stepOut/data/config/mapper.dart';

import '../../add_address/model/custom_field_model.dart';

class AddressesModel extends SingleMapper {
  String? message;
  List<AddressItem>? data;
  int? statusCode;

  AddressesModel({this.statusCode, this.message, this.data});

  AddressesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <AddressItem>[];
      json['data'].forEach((v) {
        data!.add(AddressItem.fromJson(v));
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
    return AddressesModel.fromJson(json);
  }
}

class AddressItem {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? addressDetails;
  CustomFieldItem? city;
  CustomFieldItem? area;
  bool? isDefaultAddress;

  AddressItem({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.city,
    this.area,
    this.addressDetails,
    this.isDefaultAddress,
  });

  AddressItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    addressDetails = json['address_details'];
    city = json['city'] != null ? CustomFieldItem.fromJson(json['city']) : null;
    area = json['area'] != null ? CustomFieldItem.fromJson(json['area']) : null;
    isDefaultAddress = json['is_default'] == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['city'] = city;
    data['area'] = area;
    data['address'] = address;
    data['address_details'] = addressDetails;
    data['city'] = city?.toJson();
    data['area'] = area?.toJson();
    data['is_default'] = isDefaultAddress == true ? 1 : 0;

    return data;
  }
}
