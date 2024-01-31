
class GetProductDetailsModel {
  bool status;
  String message;
  Data data;

  GetProductDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetProductDetailsModel.fromJson(Map<String, dynamic> json) => GetProductDetailsModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int? id;
  String? title;
  int? price;
  String? description;
  String? rating;
  String? brandname;
  String? categoryname;
  String? subcategoryname;
  int? quantity;
  List<String>? productImages;

  Data({
     this.id,
     this.title,
     this.price,
     this.description,
     this.rating,
     this.brandname,
     this.categoryname,
     this.subcategoryname,
     this.quantity,
     this.productImages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    description: json["description"],
    rating: json["rating"],
    brandname: json["brandname"],
    categoryname: json["categoryname"],
    subcategoryname: json["subcategoryname"],
    quantity: json["quantity"],
    productImages: List<String>.from(json["product_images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "rating": rating,
    "brandname": brandname,
    "categoryname": categoryname,
    "subcategoryname": subcategoryname,
    "quantity": quantity,
    "product_images": List<dynamic>.from(productImages!.map((x) => x)),
  };
}
