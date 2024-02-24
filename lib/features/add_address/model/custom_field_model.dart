import '../../../data/config/mapper.dart';

class CustomFieldModel extends SingleMapper {
  String? message;
  int? statusCode;
  List<CustomFieldItem>? data;

  CustomFieldModel({
    this.message,
    this.statusCode,
    this.data,
  });

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
      };

  CustomFieldModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(CustomFieldItem.fromJson(v));
      });
    }
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return CustomFieldModel.fromJson(json);
  }
}

class CustomFieldItem {
  int? id;
  String? name;
  String? deliveryFees;

  CustomFieldItem({
    this.id,
    this.name,
    this.deliveryFees,
  });

  factory CustomFieldItem.fromJson(Map<String, dynamic> json) =>
      CustomFieldItem(
        id: json["id"],
        name: json["name"] ?? "",
        deliveryFees: json["delivery_fees"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "delivery_fees": deliveryFees,
      };
}
