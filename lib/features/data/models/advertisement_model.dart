import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AdvertisementModel advertisementModelFromJson(String str) =>
    AdvertisementModel.fromJson(json.decode(str));

String advertisementModelToJson(AdvertisementModel data) =>
    json.encode(data.toJson());

class AdvertisementModel {
  String? id;
  String? title;
  String? sellerId;
  String? address;
  String? additionalDescription;
  int? bathRoom;
  int? bedRooms;
  int? kitchen;
  int? livingRoom;
  String? electricity;
  String? yard;
  String? water;
  String? type;
  String? contact;
  String? publishedDate;
  double? monthlyPrice;
  String? sellerName;
  String? province;
  double? latitude;
  double? longitude;
  bool? isPromo;
  List<dynamic>? image;

  AdvertisementModel({
    this.id,
    this.title,
    this.sellerId,
    this.address,
    this.additionalDescription,
    this.bathRoom,
    this.bedRooms,
    this.kitchen,
    this.livingRoom,
    this.electricity,
    this.yard,
    this.water,
    this.type,
    this.contact,
    this.publishedDate,
    this.monthlyPrice,
    this.sellerName,
    this.province,
    this.latitude,
    this.longitude,
    this.isPromo,
    this.image,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementModel(
        id: json["id"],
        title: json["title"],
        sellerId: json["sellerId"],
        address: json["address"],
        additionalDescription: json["additionalDescription"],
        bathRoom: json["bathRoom"],
        bedRooms: json["bedRooms"],
        kitchen: json["kitchen"],
        livingRoom: json["livingRoom"],
        electricity: json["electricity"],
        yard: json["yard"],
        water: json["water"],
        type: json["type"],
        contact: json["contact"],
        publishedDate: json["publishedDate"],
        monthlyPrice: json["monthlyPrice"]?.toDouble(),
        sellerName: json["sellerName"],
        province: json["province"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        isPromo: json["isPromo"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sellerId": sellerId,
        "address": address,
        "additionalDescription": additionalDescription,
        "bathRoom": bathRoom,
        "bedRooms": bedRooms,
        "kitchen": kitchen,
        "livingRoom": livingRoom,
        "electricity": electricity,
        "yard": yard,
        "water": water,
        "type": type,
        "contact": contact,
        "publishedDate": publishedDate,
        "monthlyPrice": monthlyPrice,
        "sellerName": sellerName,
        "province": province,
        "latitude": latitude,
        "longitude": longitude,
        "isPromo": isPromo,
        "image": image,
      };

  AdvertisementModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    title = data['title'];
    sellerId = data['sellerId'];
    address = data['address'];
    additionalDescription = data['additionalDescription'];
    bathRoom = data['bathRoom'];
    bedRooms = data['bedRooms'];
    kitchen = data['kitchen'];
    livingRoom = data['livingRoom'];
    electricity = data['electricity'];
    yard = data['yard'];
    water = data['water'];
    type = data['type'];
    contact = data['contact'];
    publishedDate = data['publishedDate'];
    monthlyPrice = data['monthlyPrice']?.toDouble();
    sellerName = data['sellerName'];
    province = data['province'];
    latitude = data['latitude']?.toDouble();
    longitude = data['longitude']?.toDouble();
    isPromo = data['isPromo'];
    image = data['image'];
  }
}
