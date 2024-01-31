

class GetBrands {
  bool status;
  String message;
  List<Datum> data;

  GetBrands({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetBrands.fromJson(Map<String, dynamic> json) => GetBrands(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String title;
  String image;

  Datum({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
