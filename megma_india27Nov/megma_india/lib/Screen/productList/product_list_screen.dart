import 'package:flutter/material.dart';
import 'package:megma_india/Widget/extention.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Model/getProductModel.dart';
import '../../Widget/customAppbar.dart';
import '../product details/product_details_screen.dart';

class ProductList_csr__Screen extends StatefulWidget {
  bool? ishomepage;
  String? sellerId;

  ProductList_csr__Screen({super.key, this.ishomepage, this.sellerId});

  @override
  State<ProductList_csr__Screen> createState() =>
      _ProductList_csr__ScreenState();
}

class _ProductList_csr__ScreenState extends State<ProductList_csr__Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.ishomepage ?? false) {
      getproduct();
    }else {
      getUserid();
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: CustomAppbar(
                textt: "All Products",
              )),
          body: isloading
              ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.secondary,
            ),
          ) : productList.isEmpty ? const Center(child: Text('Product not available'),) :
          Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 16,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height / 4.5),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        product_Details_screen(
                                            productId: productList[index]
                                                .id
                                                .toString(),
                                            ishomepage: widget.ishomepage,sellerId: widget.sellerId,sellerProductId: productList[index]
                                            .productId, ),
                                  ));
                            },
                            child: productContainer(index: index));
                      }),
                )
              ),
    );
  }

  Widget productContainer({required int index}) {
    print('${productList[index].image}_________________');
    return Container(
      width: 135,
      // height: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.secondary, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 70,
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(productList[index].image ?? ''),
                        fit: BoxFit.fill)),
              ),
              /*Container(
                alignment: Alignment.topRight,
                child: Container(
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      border: Border.all(
                          //   left: BorderSide( color: Colors.orange,width: 1),
                          // right: BorderSide(color: Colors.orange,width: 1)
                          color: AppColors.secondary,
                          width: 1)),
                  child: const Icon(
                    Icons.favorite_border,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                ),
              ),*/
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${productList[index].title.toString().capitalize()}',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${productList[index].price}',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    /*Container(
                      child: const Row(
                        children: [
                          Text(
                            '4.8',
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                        ],
                      ),
                    )*/
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.secondary,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      'Add to cart',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool isloading = false;
  String? userId ;
  String? role ;

  GetProducModel? getProducModel;
  List<Getproduct> productList = [];


  Future<void> getUserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getString('userId').toString();
    role = prefs.getString('role').toString();
    getProductForSeller();
  }


  Future<void> getproduct() async {
    setState(() {
      isloading = true;
    });
    apiBaseHelper.getAPICall(getProductUrl).then(
      (getData) {
        if (getData['status']) {
            getProducModel = GetProducModel.fromJson(getData);

            for (int i = 0; i < getProducModel!.data.length; i++) {
                productList.add(getProducModel!.data[i]);

            }
            setState(() {
              isloading = false;

            });

        } else {
          setState(() {
            isloading = false;
          });
        }
      },
    );
  }

  Future<void> getProductForSeller() async {
    setState(() {
      isloading = true;
    });
    var parms = {
      'user_id': widget.sellerId
    };
    apiBaseHelper.postAPICall(getProductForSellerUrl,parms).then(
          (getData) {
        if (getData['status']) {
          getProducModel = GetProducModel.fromJson(getData);

          //productList = (getData['data'] as List).map((e) => Getproduct.fromJson(e)).toList() ;

          productList = GetProducModel.fromJson(getData).data ;
          setState(() {
            isloading = false;

          });

        } else {
          setState(() {
            isloading = false;
          });
        }
      },
    );
  }
}
