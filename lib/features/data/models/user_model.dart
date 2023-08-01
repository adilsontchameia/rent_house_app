import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? firstName;
  String? surnName;
  String? phone;
  String? email;
  String? address;
  String? password;
  double? latitude;
  double? longitude;
  String? image;

  UserModel({
    this.id,
    this.firstName,
    this.surnName,
    this.phone,
    this.email,
    this.address,
    this.password,
    this.latitude,
    this.longitude,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        surnName: json["surnName"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        password: json["password"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "surnName": surnName,
        "phone": phone,
        "email": email,
        "address": address,
        "password": password,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
      };
}
