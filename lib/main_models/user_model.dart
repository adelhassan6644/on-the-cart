import 'package:stepOut/data/config/mapper.dart';

class UserModel extends SingleMapper {
  int? id;
  String? userName;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? countryFlag;
  String? countryCode;
  DateTime? createdAt;

  UserModel(
      {this.id,
      this.userName,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.countryCode,
      this.countryFlag,
      this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userName = json["user_name"];
    name = json["name"];
    phone = json["phone"];
    image = json["image"];
    email = json["email"];
    countryCode = json["country_code"];
    countryFlag = json["country_flag"];
    createdAt =
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "country_flag": countryFlag,
        "country_code": countryCode,
        "created_at": createdAt?.toIso8601String(),
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
