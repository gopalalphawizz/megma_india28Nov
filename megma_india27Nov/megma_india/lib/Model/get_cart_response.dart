class GetCartResponse {
  bool? status;
  String? message;
  List<CartData>? data;

  GetCartResponse({this.status, this.message, this.data});

  GetCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(new CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  int? id;
  int? customerId;
  int? sellerId;
  int? productId;
  int? quantity;
  int? price;
  int? totalAmount;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? image;
  String? rating;
  String? sellerName;

  CartData(
      {this.id,
        this.customerId,
        this.sellerId,
        this.productId,
        this.quantity,
        this.price,
        this.totalAmount,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.image,
        this.rating,
        this.sellerName});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    sellerId = json['seller_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    image = json['image'];
    rating = json['rating'];
    sellerName = json['seller_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['seller_id'] = this.sellerId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_amount'] = this.totalAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['seller_name'] = this.sellerName;
    return data;
  }
}
