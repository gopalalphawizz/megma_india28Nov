// To parse this JSON data, do
//
//     final getWorkShopList = getWorkShopListFromJson(jsonString);

import 'dart:convert';

GetWorkShopList getWorkShopListFromJson(String str) => GetWorkShopList.fromJson(json.decode(str));

String getWorkShopListToJson(GetWorkShopList data) => json.encode(data.toJson());

class GetWorkShopList {
  bool status;
  String message;
  List<WorkshopListModel> data;

  GetWorkShopList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetWorkShopList.fromJson(Map<String, dynamic> json) => GetWorkShopList(
    status: json["status"],
    message: json["message"],
    data: List<WorkshopListModel>.from(json["data"].map((x) => WorkshopListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WorkshopListModel {
  int id;
  String firstName;
  String companyName;
  String address;

  WorkshopListModel({
    required this.id,
    required this.firstName,
    required this.companyName,
    required this.address,
  });

  factory WorkshopListModel.fromJson(Map<String, dynamic> json) => WorkshopListModel(
    id: json["id"],
    firstName: json["first_name"],
    companyName: json["company_name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "company_name": companyName,
    "address": address,
  };
}
