import 'package:stepOut/data/config/mapper.dart';


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
  String? name;

  SuggestionItem({this.id, this.name});

  SuggestionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
