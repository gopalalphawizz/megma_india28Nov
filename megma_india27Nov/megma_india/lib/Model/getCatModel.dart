
class GetCatogryModel {
  bool status;
  String message;
  List<Getcat> data;

  GetCatogryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCatogryModel.fromJson(Map<String, dynamic> json) => GetCatogryModel(
    status: json["status"],
    message: json["message"],
    data: List<Getcat>.from(json["data"].map((x) => Getcat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Getcat {
  int id;
  String title;
  String image;

  Getcat({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Getcat.fromJson(Map<String, dynamic> json) => Getcat(
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
