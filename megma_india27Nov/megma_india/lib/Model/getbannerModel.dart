
class GetbannerModel {
  bool status;
  String message;
  List<BannerList> data;

  GetbannerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetbannerModel.fromJson(Map<String, dynamic> json) => GetbannerModel(
    status: json["status"],
    message: json["message"],
    data: List<BannerList>.from(json["data"].map((x) => BannerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BannerList {
  int id;
  String title;
  String image;

  BannerList({
    required this.id,
    required this.title,
    required this.image,
  });

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
    id: json["id"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
  };
}
