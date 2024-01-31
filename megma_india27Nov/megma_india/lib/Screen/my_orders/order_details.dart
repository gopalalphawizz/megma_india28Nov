import 'package:flutter/material.dart';
import 'package:megma_india/Api%20services/api_services/apiBasehelper.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Model/oder_detail_response.dart';
import 'package:megma_india/Widget/customAppbar.dart';
import 'package:megma_india/Widget/custom_app_button.dart';
import 'package:megma_india/Widget/customfunctionfor_Tostmasg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key, this.oderId}) : super(key: key);

final  String? oderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}
class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isLoading = false ;
  String? userId ;
  String? role ;

  OrderDetailData? orderDetailData ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdersDetail();
    getUserid();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        bottomSheet: orderDetailData?.orderDetail?.totalAmount == 0 || orderDetailData?.orderDetail == null ? SizedBox() : SizedBox(height: 100, child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.all(5.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
               const Text('Total Amount:',style: TextStyle(fontWeight: FontWeight.bold)),
               Text('₹ ${orderDetailData?.orderDetail?.totalAmount}', style: const TextStyle(fontWeight: FontWeight.bold),)
             ],),
           ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  acceptRejectBuyerOrder('1');
                },
                  child: btn( 'Approved',)),
              InkWell(
                onTap: (){
                  acceptRejectBuyerOrder('2');
                },
                  child: btn('Reject',)),


            ],)
        ],),),
        appBar:
        PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: CustomAppbar(
              textt: "ORDERS Detail",
            )),
        body: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.primary,),) : orderDetailData == null ? const Center(child: Text('Order not available!'),) : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Code: ${orderDetailData?.orderDetail?.orderCode}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Order Date: ${orderDetailData?.orderDetail?.orderDate}'),
                  const SizedBox(height: 10),
                  Text('Delivery Status: ${orderDetailData?.orderDetail?.deliveryStatus}'),
                  const SizedBox(height: 10),
                  Text('Order Status: ${ orderStatus(orderDetailData?.orderDetail?.orderStatus.toString() ?? '0')}', style: getStatusTextStyle(orderDetailData?.orderDetail?.orderStatus.toString() ?? ''),),
                  //const SizedBox(height: 10),
                  //Text('Payment Method: ${orderDetailData?.orderDetail?.paymentMethod}'),
                  const SizedBox(height: 10),
                  Text('Total Amount: ${orderDetailData?.orderDetail?.totalAmount}'),
                  const SizedBox(height: 10),
                  Text('Customer Name: ${orderDetailData?.orderDetail?.firstName} ${orderDetailData?.orderDetail?.lastName}'),
                  const SizedBox(height: 10),
                  Text('Seller Name: ${orderDetailData?.orderDetail?.sellerName}'),
                  const SizedBox(height: 20),
                  const Text(
                    'Products:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: (orderDetailData?.productDetail ?? []).map((product) {
                      return ListTile(
                        leading: Image.network(
                          product.productImage ??'',
                          width: 50,
                          height: 50,
                        ),
                        title: Text(product.title ??''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('Requested Quantity: ${product.requestedQuantity}'),
                          product.approvedQuantity== null ? const SizedBox() :  Text('Approved Quantity: ${product.approvedQuantity}'),

                        ],),
                        trailing: product.totalPrice == 0 ? SizedBox() : Text('Price: ${product.totalPrice}'),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
  Future<void> getUserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getString('userId').toString();
    role = prefs.getString('role').toString();
    getOrdersDetail();
  }

  Future<void> getOrdersDetail() async {
    setState(() {
      isLoading = true;
    });
    var parms = {
      'order_id':widget.oderId
    };
    apiBaseHelper.postAPICall(myOrderDetailUrl,parms).then(
          (getData) {
        if (getData['status']) {
          orderDetailData = MyOrdersDetailResponse.fromJson(getData).data;

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


 Widget btn(String title){
    return Container(
      height: 45,
      width: 150,
      decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width / (1.5) / 2)),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.whiteTemp),
        ),
      ),
    );
  }

  Future<void> acceptRejectBuyerOrder( String status) async {

    var parms = {
      'customer_id':userId,
      'order_id': widget.oderId,
      'payment_method':'cash',
      'approval_status': status,
    };

    print('${parms}');
    apiBaseHelper.postAPICall(acceptRejectOrderBuyerUrl,parms).then(
          (getData) {
            String msg = getData['message'];
            bool status = getData['status'];
        if (getData['status']) {
          customSnackbar(context, msg);
          Navigator.pop(context);

        } else {
          customSnackbar(context, msg);
        }
      },
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
}
