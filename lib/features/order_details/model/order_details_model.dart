import 'package:stepOut/data/config/mapper.dart';

import '../../../main_models/items_model.dart';
import '../../addresses/model/addresses_model.dart';

class OrderDetailsModel extends SingleMapper {
  int? id;
  int? captainId;
  int? shippingFees;
  int? total;
  int? status;
  DateTime? customerReceivingTime;
  DateTime? captainDeliveryTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  AddressItem? address;
  List<OrderItem>? items;

  OrderDetailsModel(
      {this.id,
      this.address,
      this.captainId,
      this.shippingFees,
      this.total,
      this.status,
      this.customerReceivingTime,
      this.captainDeliveryTime,
      this.createdAt,
      this.updatedAt,
      this.items});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['customer_address'] != null
        ? AddressItem.fromJson(json['customer_address'])
        : null;
    captainId = json['captain_id'];
    shippingFees = json['shipping_fees'];
    total = json['total'];
    status = json['status'];
    customerReceivingTime = json['customer_receiving_time'] != null
        ? DateTime.tryParse(json['customer_receiving_time'])
        : null;
    captainDeliveryTime = json['captain_delivery_time'] != null
        ? DateTime.tryParse(json['captain_delivery_time'])
        : null;
    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_address'] = address?.toJson();
    data['captain_id'] = captainId;
    data['shipping_fees'] = shippingFees;
    data['total'] = total;
    data['status'] = status;
    data['customer_receiving_time'] = customerReceivingTime?.toIso8601String();
    data['captain_delivery_time'] = captainDeliveryTime?.toIso8601String();
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel.fromJson(json);
  }
}

class OrderItem {
  int? id;
  int? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  ItemModel? product;

  OrderItem(
      {this.id, this.quantity, this.createdAt, this.updatedAt, this.product});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;
    product =
        json['product'] != null ? ItemModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    if (product != null) {
      data['product'] = product?.toJson();
    }
    return data;
  }
}
