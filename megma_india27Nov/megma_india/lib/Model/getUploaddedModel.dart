
class GetUploadedModel {
  bool status;
  String message;
  List<UploadedListModel> data;

  GetUploadedModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUploadedModel.fromJson(Map<String, dynamic> json) => GetUploadedModel(
    status: json["status"],
    message: json["message"],
    data: List<UploadedListModel>.from(json["data"].map((x) => UploadedListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UploadedListModel {
  int?  id;
  int ? userId;
  int? sellerId;
  int ? productId;
  String?  registrationNo;
  String?  chasisNo;
  String? video;
  String ? odometerReading;
  String?  odometerImage;
  DateTime?  installationDate;
  String?  mileage;
  DateTime?  createdAt;
  DateTime?  updatedAt;

  UploadedListModel({
    this.id,
    this.userId,
    this.sellerId,
    this.productId,
    this.registrationNo,
    this.chasisNo,
    this.video,
    this.odometerReading,
    this.odometerImage,
    this.installationDate,
    this.mileage,
    this.createdAt,
    this.updatedAt,
  });

  factory UploadedListModel.fromJson(Map<String, dynamic> json) => UploadedListModel(
    id: json["id"],
    userId: json["user_id"],
    sellerId: json["seller_id"],
    productId: json["product_id"],
    registrationNo: json["registration_no"],
    chasisNo: json["chasis_no"],
    video: json["video"],
    odometerReading: json["odometer_reading"],
    odometerImage: json["odometer_image"],
    installationDate: DateTime.parse(json["installation_date"]),
    mileage: json["mileage"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "seller_id": sellerId,
    "product_id": productId,
    "registration_no": registrationNo,
    "chasis_no": chasisNo,
    "video": video,
    "odometer_reading": odometerReading,
    "odometer_image": odometerImage,
    "installation_date": installationDate,
    "mileage": mileage,
    "created_at": createdAt,
    "updated_at": updatedAt
  };
}
