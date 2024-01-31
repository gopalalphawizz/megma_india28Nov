import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:megma_india/Widget/custom_app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiConstants.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/productDetailsModel.dart';
import '../../Widget/customAppbar.dart';
import '../../Widget/customfunctionfor_Tostmasg.dart';
import '../cartScreen/cart_screen.dart';

class product_Details_screen extends StatefulWidget {
  String? sellerId;
  bool? ishomepage;
  String? productId;
  String? sellerProductId;

  product_Details_screen(
      {super.key, this.productId, this.sellerId, this.ishomepage, this.sellerProductId});

  @override
  State<product_Details_screen> createState() => _product_Details_screenState();
}

class _product_Details_screenState extends State<product_Details_screen> {
  @override
  void initState() {
    // TODO: implement initState
    getproductDetails();
  }

  CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  List<String> images = [
    "assets/mercedes_brakepads1.jpeg",
    "assets/mercedes_brakepads1.jpeg",
    "assets/mercedes_brakepads1.jpeg"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: CustomAppbar(
              textt: "${getProductDetailsModel?.data.title ?? ""}",
            )),
        body: !isloading
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.22,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      items: getProductDetailsModel?.data.productImages!
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "${item}",
                                        ),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Center(
                      child: Container(
                        width: 100,
                        height: 8,
                        child: Center(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: getProductDetailsModel!
                                .data.productImages!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: index == currentIndex
                                      ? AppColors.secondary
                                      : Colors.black,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 5,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // Center(
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //
                    //       for(int i=0;i < 3;i++ )
                    //         currentIndex == i ?   Container(
                    //           margin: const EdgeInsets.all(2),
                    //           height: 8,
                    //           width: 8,
                    //           decoration:const  BoxDecoration(
                    //               color:   Color(0XFFF36B28),
                    //               shape: BoxShape.circle
                    //           ),
                    //
                    //         ):Container(
                    //           margin: const EdgeInsets.all(2),
                    //           height: 8,
                    //           width: 8,
                    //           decoration: const BoxDecoration(
                    //               color: Color(0XFF020302),
                    //               shape: BoxShape.circle
                    //           ),
                    //
                    //         ),
                    //     ],
                    //   ),),

                    Text('${getProductDetailsModel?.data.title ?? ""}',
                        style: TextStyle(
                            color: Color(0XFF24253D),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),

                    Html(
                        data:
                            '${getProductDetailsModel?.data.description ?? ""}'),
                    // Text('${getProductDetailsModel?.data.description??""}',style: TextStyle(color: Color(0XFF24253D),fontSize: 16)),
                    // SizedBox(height: ,),


                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.secondary)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            InkWell(
                                onTap: () {
                                  decrement();
                                },
                                child: Icon(Icons.remove)),

                            Text(quantity.toString()),
                            InkWell(
                                onTap: () {
                                  increnent();
                                },
                                child: Icon(Icons.add)),
                          ]),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 10),

                    Center(
                        child: InkWell(
                            onTap: () {
                              addtocart();
                            },
                            child: CustomButton(textt: "Add to Cart"))),
                  ],
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingWidget2(context)
                ),
              ),
      ),
    );
  }

  bool isloading = false;
  GetProductDetailsModel? getProductDetailsModel;

  Future<void> getproductDetails() async {
    var parameter;

    setState(() {
      isloading = true;
    });
    if (widget.ishomepage == true) {
      parameter = {
        "product_id": widget.productId.toString(),
        "seller_id": "",
      };
    } else {
      parameter = {
        "product_id": widget.sellerProductId.toString(),
        "seller_id": widget.sellerId.toString(),
      };
    }
    apiBaseHelper.postAPICall(getproductdetailsUrl, parameter).then(
      (getData) {
        print(getData);
        if (getData['status']) {
          setState(() {
            getProductDetailsModel = GetProductDetailsModel.fromJson(getData);

            setState(() {
              price = getProductDetailsModel?.data.price ?? 0;
              getquantity = getProductDetailsModel?.data.quantity ?? 0;
              print(price);
              isloading = false;
            });
          });
        } else {
          setState(() {
            isloading = false;
          });
        }
      },
    );
  }

  int price = 0;
  int totalamount = 0;
  int getquantity = 0;
  int quantity = 1;

  void increnent() {

      setState(() {
        quantity++;
        totalamount = price * quantity;
        print(totalamount);
      });

  }

  void decrement() {
    if (quantity > 1)
      setState(() {
        quantity--;
        totalamount = price * quantity;
        print(totalamount);
      });
  }

  Future<void> addtocart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId;
    setState(() {
      userId = prefs.getString('userId').toString();
    });
    var parameter;
    if (widget.ishomepage == true) {
      parameter = {
        'customer_id': userId.toString(),
        'seller_id': '1',
        'product_id': widget.productId.toString(),
        'quantity': quantity.toString(),
        'price': price.toString(),
        'total_amount': totalamount.toString(),
      };
    } else {
      parameter = {
        'customer_id': userId.toString(),
        'seller_id': widget.sellerId.toString(),
        'product_id': widget.productId.toString(),
        'quantity': quantity.toString(),
        'price': price.toString(),
        'total_amount': totalamount.toString(),
      };
    }
    apiBaseHelper.postAPICall(addtocartUrl, parameter).then(
      (getData) {
        if (getData['status']) {
          setState(() {
            customSnackbar(context, "${getData['message'].toString()}");

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ));
          });
        } else {
          customSnackbar(context, "${getData['message'].toString()}");
        }
      },
    );
  }
}
