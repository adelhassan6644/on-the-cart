import 'package:stepOut/data/config/mapper.dart';

class LocationModel extends SingleMapper {
  String? latitude;
  String? longitude;
  String? address;

  LocationModel({
    this.address,
    this.latitude,
    this.longitude,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['lat'];
    longitude = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['lat'] = latitude;
    data['long'] = longitude;

    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
