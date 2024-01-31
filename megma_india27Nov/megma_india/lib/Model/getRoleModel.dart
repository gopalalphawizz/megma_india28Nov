// To parse this JSON data, do
//
//     final getRoleModel = getRoleModelFromJson(jsonString);

import 'dart:convert';

GetRoleModel getRoleModelFromJson(String str) => GetRoleModel.fromJson(json.decode(str));

String getRoleModelToJson(GetRoleModel data) => json.encode(data.toJson());

class GetRoleModel {
  bool status;
  String message;
  List<RoleData> data;

  GetRoleModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetRoleModel.fromJson(Map<String, dynamic> json) => GetRoleModel(
    status: json["status"],
    message: json["message"],
    data: List<RoleData>.from(json["data"].map((x) => RoleData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RoleData {
  int id;
  String name;

  RoleData({
    required this.id,
    required this.name,
  });

  factory RoleData.fromJson(Map<String, dynamic> json) => RoleData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
