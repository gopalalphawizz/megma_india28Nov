class MyOrdersResponse {
  bool? status;
  String? message;
  List<MyOrderData>? data;

  MyOrdersResponse({this.status, this.message, this.data});

  MyOrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyOrderData>[];
      json['data'].forEach((v) {
        data!.add(MyOrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyOrderData {
  int? id;
  String? orderCode;
  String? orderDate;
  int? orderStatus;
  String? qrcode;
  int? totalAmount;

  MyOrderData(
      {this.id,
        this.orderCode,
        this.orderDate,
        this.orderStatus,
        this.qrcode,
        this.totalAmount});

  MyOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    qrcode = json['qrcode'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_code'] = orderCode;
    data['order_date'] = orderDate;
    data['order_status'] = orderStatus;
    data['qrcode'] = qrcode;
    data['total_amount'] = totalAmount;
    return data;
  }
}
