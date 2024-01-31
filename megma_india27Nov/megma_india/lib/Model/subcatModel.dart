
class GetSubCatModel {
  bool status;
  String message;
  List<Sub_Category> data;

  GetSubCatModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetSubCatModel.fromJson(Map<String, dynamic> json) => GetSubCatModel(
    status: json["status"],
    message: json["message"],
    data: List<Sub_Category>.from(json["data"].map((x) => Sub_Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Sub_Category {
  int id;
  String title;
  String image;
  int categoryId;

  Sub_Category({
    required this.id,
    required this.title,
    required this.image,
    required this.categoryId,
  });

  factory Sub_Category.fromJson(Map<String, dynamic> json) => Sub_Category(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "category_id": categoryId,
  };
}
