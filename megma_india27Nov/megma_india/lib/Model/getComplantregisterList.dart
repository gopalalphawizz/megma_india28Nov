
class GetComplantRegisterList {
  bool status;
  String message;
  List<ComplantListModel> data;

  GetComplantRegisterList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetComplantRegisterList.fromJson(Map<String, dynamic> json) => GetComplantRegisterList(
    status: json["status"],
    message: json["message"],
    data: List<ComplantListModel>.from(json["data"].map((x) => ComplantListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ComplantListModel {
  int id;
  DateTime claimDate;
  int claimStatus;
  int warrantyStatus;
  String productName;

  ComplantListModel({
    required this.id,
    required this.claimDate,
    required this.claimStatus,
    required this.warrantyStatus,
    required this.productName,
  });

  factory ComplantListModel.fromJson(Map<String, dynamic> json) => ComplantListModel(
    id: json["id"],
    claimDate: DateTime.parse(json["claim_date"]),
    claimStatus: json["claim_status"],
    warrantyStatus: json["warranty_status"],
    productName: json["product_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "claim_date": "${claimDate.year.toString().padLeft(4, '0')}-${claimDate.month.toString().padLeft(2, '0')}-${claimDate.day.toString().padLeft(2, '0')}",
    "claim_status": claimStatus,
    "warranty_status": warrantyStatus,
    "product_name": productName,
  };
}
