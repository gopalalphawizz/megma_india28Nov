
class GetProducModel {
  bool status;
  String message;
  List<Getproduct> data;

  GetProducModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetProducModel.fromJson(Map<String, dynamic> json) => GetProducModel(
    status: json["status"],
    message: json["message"],
    data: List<Getproduct>.from(json["data"].map((x) => Getproduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Getproduct {
  int? id;
  String? title;
  int? price;
  int? quantity;


  String? image;
  String? productId;
  String? userId;
  int? stock;

  Getproduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
     this.image,
     this.productId,
     this.stock,
     this.userId,
  });

  factory Getproduct.fromJson(Map<String, dynamic> json) => Getproduct(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    quantity: json["quantity"],
    image: json["image"],
    productId: json["product_id"].toString(),
    stock: json["stock"],
    userId: json["user_id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "quantity": quantity,
    "image": image,
  };
}
