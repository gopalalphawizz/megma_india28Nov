

class GetPrivecyModel {
  bool status;
  String message;
  List<Datum> data;

  GetPrivecyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetPrivecyModel.fromJson(Map<String, dynamic> json) => GetPrivecyModel(
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
  String slug;
  String content;
  DateTime? createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    content: json["content"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "content": content,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
