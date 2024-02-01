import 'package:stepOut/data/config/mapper.dart';

class OrderDetailsModel extends SingleMapper {
  int? id;
  String? image;
  String? title;
  OrderDetailsModel({this.id, this.image, this.title});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel.fromJson(json);
  }
}
