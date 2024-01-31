class MyOrdersDetailResponse {
  bool? status;
  String? message;
  OrderDetailData? data;

  MyOrdersDetailResponse({this.status, this.message, this.data});

  MyOrdersDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OrderDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrderDetailData {
  OrderDetail? orderDetail;
  List<ProductDetail>? productDetail;

  OrderDetailData({this.orderDetail, this.productDetail});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    orderDetail = json['order_detail'] != null
        ? OrderDetail.fromJson(json['order_detail'])
        : null;
    if (json['product_detail'] != null) {
      productDetail = <ProductDetail>[];
      json['product_detail'].forEach((v) {
        productDetail!.add(ProductDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetail != null) {
      data['order_detail'] = orderDetail!.toJson();
    }
    if (productDetail != null) {
      data['product_detail'] =
          productDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetail {
  int? id;
  int? sellerId;
  int? customerId;
  String? orderCode;
  String? orderDate;
  String? deliveryDate;
  int? deliveryStatus;
  int? orderStatus;
  String? qrcode;
  String? amount;
  String? paymentMethod;
  String? discount;
  String? expectedDiscount;
  String? couponId;
  int? totalAmount;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? sellerName;
  String? customerName;

  OrderDetail(
      {this.id,
        this.sellerId,
        this.customerId,
        this.orderCode,
        this.orderDate,
        this.deliveryDate,
        this.deliveryStatus,
        this.orderStatus,
        this.qrcode,
        this.amount,
        this.paymentMethod,
        this.discount,
        this.expectedDiscount,
        this.couponId,
        this.totalAmount,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.lastName,
        this.sellerName,this.customerName});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    customerId = json['customer_id'];
    orderCode = json['order_code'];
    orderDate = json['order_date'];
    deliveryDate = json['delivery_date'];
    deliveryStatus = json['delivery_status'];
    orderStatus = json['order_status'];
    qrcode = json['qrcode'];
    amount = json['amount'].toString();
    paymentMethod = json['payment_method'];
    discount = json['discount'].toString();
    expectedDiscount = json['expected_discount'].toString();
    couponId = json['coupon_id'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    sellerName = json['seller_name'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seller_id'] = sellerId;
    data['customer_id'] = customerId;
    data['order_code'] = orderCode;
    data['order_date'] = orderDate;
    data['delivery_date'] = deliveryDate;
    data['delivery_status'] = deliveryStatus;
    data['order_status'] = orderStatus;
    data['qrcode'] = qrcode;
    data['amount'] = amount;
    data['payment_method'] = paymentMethod;
    data['discount'] = discount;
    data['expected_discount'] = expectedDiscount;
    data['coupon_id'] = couponId;
    data['total_amount'] = totalAmount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['seller_name'] = sellerName;
    data['customer_name'] = customerName;
    return data;
  }
}

class ProductDetail {
  int? id;
  int? orderId;
  int? productId;
  int? requestedQuantity;
  int? approvedQuantity;
  int? status;
  int? price;
  int? totalPrice;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? productImage;

  ProductDetail(
      {this.id,
        this.orderId,
        this.productId,
        this.requestedQuantity,
        this.approvedQuantity,
        this.status,
        this.price,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.productImage});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    requestedQuantity = json['requested_quantity'];
    approvedQuantity = json['approved_quantity'];
    status = json['status'];
    price = json['price'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['requested_quantity'] = requestedQuantity;
    data['approved_quantity'] = approvedQuantity;
    data['status'] = status;
    data['price'] = price;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['product_image'] = productImage;
    return data;
  }
}
