import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Model/get_sellers_response.dart';
import 'package:megma_india/Widget/extention.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiConstants.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/getCatModel.dart';
import '../../Model/getProductModel.dart';
import '../../Model/getbannerModel.dart';
import '../../Model/getworkshopformechanic.dart';
import '../Catogery Screen/CatogryScreen.dart';
import '../Sub Cat/sub_cat_screen.dart';
import '../cartScreen/cart_screen.dart';
import '../product details/product_details_screen.dart';
import '../productList/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getbanner();

    getUserid();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:




          !isLading?
          
          
          Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Container(
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 1,
                    ),
                  ],

                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  // border: Border.all(color: Colors.black.withOpacity(0.3)
                  //
                  // )
                ),
                child: const TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.fieldColors,
                    ),
                    hintText: "Search",
                    hintStyle:
                        TextStyle(fontSize: 15, color: AppColors.fieldColors),
                    border: InputBorder.none,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 24,
                  color: AppColors.fieldTextColors,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: getsliderList
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
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: 100,
                height: 6,
                child: Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index == currentIndex
                              ? AppColors.secondary
                              : const Color(0xffFEE9E9E9),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Category_Screen()));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: catogryList.length>4?4:catogryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Sub_Category_Screen(
                                getCatogryModel: getCatogryModel,
                                indexx: index),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondary,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${catogryList[index].image}"),
                                  fit: BoxFit.fill)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 70,
                            child: Text(
                              '${catogryList[index].title}',
                              style: const TextStyle(
                                fontSize: 8,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           ProductList_csr__Screen(ishomepage: true),
                    //     ));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Category_Screen()));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 160,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productList.length>3?3:productList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => product_Details_screen(
                      //           productId: productList[index].id.toString(),
                      //           ishomepage: true),
                      //     ));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Category_Screen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: productContainer(index: index),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),

              getWorkshopList.isNotEmpty ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WorkShop',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: getWorkshopList.length ?? 0,
                    itemBuilder: (context, index) {
                      var item = getWorkshopList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: mechanicWidget(item as WorkshopListModel),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 0,
                      );
                    },
                  ),
                ),
              ],) : const SizedBox(),


            /*Center(
              child: SizedBox(
                width: 100,
                height: 6,
                child: Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index == currentIndex
                              ? AppColors.secondary
                              : const Color(0xffFEE9E9E9),
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
            ),*/



            sellerData?.disributorList != null ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text(
                'Distributors',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 110,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: sellerData?.disributorList?.length ?? 0,
                  itemBuilder: (context, index) {
                    var item = sellerData?.disributorList?[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: sellersWidget(item),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 0,
                    );
                  },
                ),
              ),
            ],) : const SizedBox()
            /*Center(
              child: Container(
                width: 100,
                height: 6,
                child: Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index == currentIndex
                              ? AppColors.secondary
                              : const Color(0xffFEE9E9E9),
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
            ),*/,
            sellerData?.retailorList != null ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Retailers',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: sellerData?.retailorList?.length ?? 0,
                    itemBuilder: (context, index) {
                      var item = sellerData?.retailorList?[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: sellersWidget(item),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 0,
                      );
                    },
                  ),
                ),
            ],) :  const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            /*Center(
              child: SizedBox(
                width: 100,
                height: 6,
                child: Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index == currentIndex
                              ? AppColors.secondary
                              : const Color(0xffFEE9E9E9),
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
            ),*/
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ):
              
              
              Container(height: MediaQuery.of(context).size.height/1.2,width: MediaQuery.of(context).size.width,


              child: Center(child: LoadingWidget2(context),),
              )
      
      
      )
        
        
          
          
    );
  }

  Widget mechanicWidget(WorkshopListModel? data2  ) {
    return InkWell(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList_csr__Screen(sellerId:data2?.id.toString()),));
      },

      child: SizedBox(
        width: 160,
        child: Stack(
          children: [
            Container(
              width: 160,
              height: 70,
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.secondary)),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.person,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        data2?.companyName??'',
                        style:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.pin_drop_sharp,
                        color: AppColors.secondary,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                           '${data2?.address??''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 160,
              alignment: Alignment.topCenter,
              child: Container(
                height: 55,
                width: 55,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                             'assets/images/227-2271457_dummy-image-jpg.png'),
                        fit: BoxFit.fill),
                    border: Border.all(color: AppColors.secondary, width: 1)),
                // child: const Image(
                //   image: AssetImage('assets/images/227-2271457_dummy-image-jpg.png'),
                //   fit: BoxFit.fill,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sellersWidget(SellersListData? data  ) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList_csr__Screen(sellerId: data?.id.toString()),));
      },
      child: SizedBox(
        width: 160,
        child: Stack(
          children: [
            Container(
              width: 160,
              height: 70,
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.secondary)),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.person,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        data?.firstName.toString().capitalize() ?? '',
                        style:
                            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.pin_drop_sharp,
                        color: AppColors.secondary,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          data?.address ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],

                  ),
                ],
              ),
            ),
            Container(
              width: 160,
              alignment: Alignment.topCenter,
              child: Container(
                height: 55,
                width: 55,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            data?.userImage ?? ''),
                        fit: BoxFit.fill),
                    border: Border.all(color: AppColors.secondary, width: 1)),
                // child: const Image(
                //   image: AssetImage('assets/images/227-2271457_dummy-image-jpg.png'),
                //   fit: BoxFit.fill,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productContainer({required int index}) {
    return Stack(
      children: [
        Container(
          width: 135,
          // height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.secondary, width: 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      '${productList[index].title!.capitalize()}',
                      style:
                          const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹ ${productList[index].price}',
                          style: const TextStyle(
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.secondary,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        /*Container(
          height: 30,
          width: 135,
          child: Row(
            children: [
              Spacer(),
              Container(
                // alignment: Alignment.topRight,
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(9),
                        bottomLeft: Radius.circular(9)),
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
            ],
          ),
        ),*/
      ],
    );
  }

  List<String> carImageList = [
    'assets/images/Group 6770.png',
    'assets/images/Group 6769.png',
    'assets/images/Group 74839.png',
    'assets/images/Group 74839.png',
    'assets/images/Group 74839.png',
    'assets/images/Group 74839.png',
    'assets/images/Group 74843.png',
    'assets/images/Group 74843.png',
  ];

  final items = [
    Image.asset(
      'assets/images/banner2.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/banner002.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/banner003.png',
      fit: BoxFit.fill,
    ),
  ];
  int currentIndex = 99;

  // List<String> productListImage = [
  //   'assets/images/41OpBJoqq+L.png',
  //   'assets/images/51eqZmyasJL-removebg-preview.png',
  //   'assets/images/Ceramic-Car-Brake-Pads-Excellent-Manufacturer-Durable-No-Dust-Quiet-D872-for-Mercedes-Benz-C-Class-E-Class-S-Class-Clk-Cls-Slk-SLR-removebg-preview.png',
  //   'assets/images/41OpBJoqq+L.png',
  //   'assets/images/51eqZmyasJL-removebg-preview.png',
  //   'assets/images/41OpBJoqq+L.png',
  //   'assets/images/51eqZmyasJL-removebg-preview.png',
  //   'assets/images/51eqZmyasJL-removebg-preview.png',
  // ];

  GetbannerModel? getbannerModel;
  List getsliderList = [];

  Future<void> getbanner() async {
    
    setState(() {
      isLading=true;
    });
    apiBaseHelper.getAPICall(getBannerUrl).then(
      (getData) {
        print(getData);
        if (getData['status']) {
          setState(() {
            getbannerModel = GetbannerModel.fromJson(getData);

            for (int i = 0; i < getbannerModel!.data.length; i++) {
              setState(() {
                getsliderList.add(getbannerModel?.data[i].image);
              });
            }

            print("============${getsliderList.length}");
          });

          setState(() {
            isLading=false;
          });
        } else {}
      },
    );
  }

  GetCatogryModel? getCatogryModel;
  List<Getcat> catogryList = [];

  Future<void> getcat() async {
    apiBaseHelper.getAPICall(getcatogryUrl).then(
      (getData) {
        if (getData['status']) {
          setState(() {
            getCatogryModel = GetCatogryModel.fromJson(getData);

            for (int i = 0; i < getCatogryModel!.data.length; i++) {
              setState(() {
                catogryList.add(getCatogryModel!.data[i]);
              });
            }

            print("============${catogryList.length}");
          });
        } else {}
      },
    );
  }

  GetProducModel? getProducModel;
  List<Getproduct> productList = [];
  String? userId;
  String? role;
  SellerData? sellerData;
  bool isLading = false;

  Future<void> getproduct() async {
    apiBaseHelper.getAPICall(getProductUrl).then(
      (getData) {
        if (getData['status']) {
          setState(() {
            getProducModel = GetProducModel.fromJson(getData);

            for (int i = 0; i < getProducModel!.data.length; i++) {
              setState(() {
                productList.add(getProducModel!.data[i]);
              });
            }

            print("============${productList.length}");
          });
        } else {}
      },
    );
  }

  Future<void> getUserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getString('userId').toString();
    role = prefs.getString('role').toString();
    // getSellers();
    getcat();
    getproduct();
    if(role=='6'){
      getworkshop();
    }

  }

  Future<void> getSellers() async {

    var prms = {'user_id': userId};

    apiBaseHelper.postAPICall(getSellersUrl, prms).then(
      (getData) {
        if (getData['status']) {

          setState(() {
            sellerData = SellerData.fromJson(getData['data']);
            print('${sellerData?.disributorList?.length}__________________');
            print('${sellerData?.disributorList != null}__________________');

          });
        } else {

        }
      },
    );
  }

  List<WorkshopListModel> getWorkshopList=[];
void getworkshop(){
   apiBaseHelper.getAPICall(getWorkshopUrl).then((getData){
     bool error=getData['status'];
     String msg=getData['message'];
     if(error==true){

       getWorkshopList=GetWorkShopList.fromJson(getData).data??[];
     }


   });


}
}
