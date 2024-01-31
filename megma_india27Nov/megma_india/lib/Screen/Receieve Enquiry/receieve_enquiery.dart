import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:megma_india/Api%20services/api_services/apiBasehelper.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:megma_india/Model/getProductModel.dart';
import 'package:megma_india/Model/my_orders_response.dart';
import 'package:megma_india/Screen/Receieve%20Enquiry/received_orders_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api services/api_services/apiConstants.dart';
import '../../../Helper/Colors.dart';
import '../../../Model/faqModel.dart';
import '../../../Widget/customAppbar.dart';
class ReceivedOrders extends StatefulWidget {
  const   ReceivedOrders({super.key,});


  @override
  State<ReceivedOrders> createState() => _ReceivedOrdersState();
}

class _ReceivedOrdersState extends State<ReceivedOrders> {


  bool isLoading = false ;
  String? userId ;
  String? role ;
  List <MyOrderData> myReceivedOderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserid();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
        PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: CustomAppbar(
              textt: "ORDERS RECEIVED BY ME",
            )),
        body: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.primary,),) : myReceivedOderList.isEmpty ? const Center(child: Text('Order not available!'),) : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myReceivedOderList.length,
                itemBuilder: (context, index) {
                  return listTileWidget(index: index);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              )
            ])),
      ),
    );
  }


  Widget listTileWidget({required int index}) {
    var item = myReceivedOderList[index];
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReceivedOrderDetailsScreen(oderId: item.id.toString()),));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Container(
          //width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.only(left: 10),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Code:",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Date:",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Status:",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.orderCode.toString() ??"",
                      style: const TextStyle(
                        fontSize: 12,fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      item.orderDate.toString(),
                      style: const TextStyle(
                        fontSize: 12,fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        orderStatus(item.orderStatus.toString()),
                        style: getStatusTextStyle(item.orderStatus.toString())

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle getStatusTextStyle(String status) {
    // Set colors based on different order statuses
    Color textColor = Colors.black;

    if (status == '0') {
      textColor = Colors.red;
    } else if (status == '1') {
      textColor = Colors.blueAccent;
    } else if (status == '2') {
      textColor = Colors.grey;
    } else if (status == '3') {
      textColor = AppColors.primary;
    }

    // Return the TextStyle with the determined color
    return TextStyle(
      color: textColor,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
  }

  String orderStatus(String status){
    if (status == '0') {
      return 'Pending';
    } else if (status == '1') {
      return 'InProgress';
    } else if (status == '2') {
      return 'Rejected';
    } else if (status == '3') {
      return 'Waiting for your approval';
    }else {
      return 'Approved' ;
    }
  }

  Future<void> getUserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getString('userId').toString();
    role = prefs.getString('role').toString();
    getReceivedOrders();
  }

  Future<void> getReceivedOrders() async {
    setState(() {
      isLoading = true;
    });
    var parms = {
      'user_id':userId
    };
    apiBaseHelper.postAPICall(myReceivedOrderUrl,parms).then(
          (getData) {
        if (getData['status']) {
          myReceivedOderList = MyOrdersResponse.fromJson(getData).data ?? [];

          //productList = (getData['data'] as List).map((e) => Getproduct.fromJson(e)).toList() ;

          setState(() {
            isLoading = false;

          });

        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }
}