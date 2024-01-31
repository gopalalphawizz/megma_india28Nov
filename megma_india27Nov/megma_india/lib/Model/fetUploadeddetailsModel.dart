
class GetUploadeddetailsModel {
  bool status;
  String message;
  UploadeddetailLData data;

  GetUploadeddetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUploadeddetailsModel.fromJson(Map<String, dynamic> json) => GetUploadeddetailsModel(
    status: json["status"],
    message: json["message"],
    data: UploadeddetailLData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class UploadeddetailLData {
  int id;
  int userId;
  int sellerId;
  int productId;
  String registrationNo;
  String chasisNo;
  String video;
  String odometerReading;
  String odometerImage;
  DateTime installationDate;
  String mileage;
  DateTime createdAt;
  DateTime updatedAt;
  String productname;
  String companyName;
  List<String> uploadImages;

  UploadeddetailLData({
    required this.id,
    required this.userId,
    required this.sellerId,
    required this.productId,
    required this.registrationNo,
    required this.chasisNo,
    required this.video,
    required this.odometerReading,
    required this.odometerImage,
    required this.installationDate,
    required this.mileage,
    required this.createdAt,
    required this.updatedAt,
    required this.productname,
    required this.companyName,
    required this.uploadImages,
  });

  factory UploadeddetailLData.fromJson(Map<String, dynamic> json) => UploadeddetailLData(
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
    productname: json["productname"],
    companyName: json["company_name"],
    uploadImages: List<String>.from(json["upload_images"].map((x) => x)),
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
    "installation_date": "${installationDate.year.toString().padLeft(4, '0')}-${installationDate.month.toString().padLeft(2, '0')}-${installationDate.day.toString().padLeft(2, '0')}",
    "mileage": mileage,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "productname": productname,
    "company_name": companyName,
    "upload_images": List<dynamic>.from(uploadImages.map((x) => x)),
  };
}
