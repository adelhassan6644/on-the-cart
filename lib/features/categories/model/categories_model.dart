import 'package:stepOut/data/config/mapper.dart';
import 'package:stepOut/main_models/base_model.dart';

class CategoriesModel extends SingleMapper {
  String? message;
  List<CategoryItem>? data;
  int? statusCode;

  CategoriesModel({this.statusCode, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <CategoryItem>[];
      json['data'].forEach((v) {
        data!.add(CategoryItem.fromJson(v));
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
    return CategoriesModel.fromJson(json);
  }
}

class CategoryItem extends BaseModel {
  CategoryItem({
    super.id,
    super.isStore = false,
    super.image,
    super.name = "Category Name",
    super.description,
  });

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    isStore = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['is_store'] = false;

    return data;
  }
}
