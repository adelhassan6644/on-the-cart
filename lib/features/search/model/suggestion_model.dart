import 'package:stepOut/data/config/mapper.dart';

import '../../../main_models/base_model.dart';

class SuggestionModel extends SingleMapper {
  String? message;
  List<SuggestionItem>? data;
  int? statusCode;

  SuggestionModel({this.statusCode, this.message, this.data});

  SuggestionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <SuggestionItem>[];
      json['data'].forEach((v) {
        data!.add(SuggestionItem.fromJson(v));
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
    return SuggestionModel.fromJson(json);
  }
}

class SuggestionItem {
  int? id;
  String? title;

  SuggestionItem({this.id, this.title});

  SuggestionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
