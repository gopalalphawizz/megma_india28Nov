class GetSellersResponse {
  bool? status;
  String? message;
  SellerData? data;

  GetSellersResponse({this.status, this.message, this.data});

  GetSellersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SellerData.fromJson(json['data']) : null;
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

class SellerData {
  List<SellersListData>? disributorList;
  List<SellersListData>? retailorList;

  SellerData({this.disributorList, this.retailorList});

  SellerData.fromJson(Map<String, dynamic> json) {
    if (json['distributor_list'] != null) {
      disributorList = <SellersListData>[];
      json['distributor_list'].forEach((v) {
        disributorList!.add(SellersListData.fromJson(v));
      });
    }
    if (json['retailer_list'] != null) {
      retailorList = <SellersListData>[];
      json['retailer_list'].forEach((v) {
        retailorList!.add(SellersListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (disributorList != null) {
      data['distributor_list'] =
          disributorList!.map((v) => v.toJson()).toList();
    }
    if (retailorList != null) {
      data['retailer_list'] =
          retailorList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellersListData {
  String? firstName;
  String? lastName;
  String? address;
  String? userImage;
  int? id;


  SellersListData(
      {this.firstName, this.lastName, this.address, this.userImage, this.id});

  SellersListData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    userImage = json['user_image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['user_image'] = userImage;
    data['id'] = id;
    return data;
  }
}
