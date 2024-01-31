import 'package:flutter/material.dart';
import 'package:megma_india/Api%20services/api_services/apiBasehelper.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Model/get_cart_response.dart';
import 'package:megma_india/Screen/ThankYou/ThankYour.dart';
import 'package:megma_india/Widget/customAppbar.dart';
import 'package:megma_india/Widget/custom_app_button.dart';
import 'package:megma_india/Widget/customfunctionfor_Tostmasg.dart';
import 'package:megma_india/Widget/extention.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? userid ;
  String? role ;
  bool isPlaceOrder = false ;

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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child:

            CustomAppbar(
              textt: "Your Cart",
            )),
        bottomSheet: SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              /*const SizedBox(height: 10,),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0XFFF2F2F2),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [BoxShadow(
                        color:  Color(0XFF00000029),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(2, 3)
                    )]
                ),
                child: DropdownButton(

                    underline: const SizedBox(),
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    hint: const Text("Select Vendor"),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: [],
                    onChanged: (val){}),
              ),
              const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                      height: 50,

                      decoration: BoxDecoration(
                          color: const Color(0XFFF2F2F2),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [BoxShadow(
                              color:  Color(0XFF00000029),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(2, 3)
                          )]
                      ),
                      child:const  Text("Expected Discount",style: TextStyle(color:Color(0XFF888A8D) ),)
                  ),
                ),
              ],
            ),*/
            const SizedBox(height: 10,),
              InkWell(
                  onTap: () {
                    placeOrderRequest();
                  },
                  child: isPlaceOrder ? Center(child: CircularProgressIndicator(color: AppColors.primary,),) : CustomButton(textt: "Place Order Request")),
          ],),
        ),
        backgroundColor: Colors.white,
        body: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.secondary),) : cartList.isEmpty ? const Center(child: Text('No item available!'),) : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                productCardWidget(),

                const SizedBox(height: 10,),



              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> getUserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userid = prefs.getString('userId').toString();
    role = prefs.getString('role').toString();
    getCart();
  }

  List <CartData> cartList = [];

  bool isLoading = false ;

  Map<String,dynamic>carData = {
    "mercedes": [
      {
        "name": "Severe Duty Brake Pads",
        "image": "assets/mercedes_brakepads1.jpeg",
        'price':"2100"
      },
      {
        "name": "Maxvalue Brake Pads",
        "image": "assets/mercedes-benz-brake-pad.jpg",
        'price':"3500"
      },
      {
        "name": "Premium Brake Shoes",
        "image": "assets/mercedes_brakepads1.jpeg",
        'price':"2100"
      },
      {
        "name": "Pro Series Disc Brake Rotors",
        "image": "assets/mercedes-benz-brake-pad.jpg",
        'price':"3500"
      }
    ]
  };


  Future<void>getCart() async{
    setState(() {
      isLoading = true ;
    });
    var parms = {
      'user_id': userid
    };
    apiBaseHelper.postAPICall(getCartUrl, parms).then((getData) {
      bool status = getData['status'];
      String msg = getData['message'];
      if(status){
        cartList = GetCartResponse.fromJson(getData).data ?? [] ;
        setState(() {
          isLoading = false ;
        });
      }else {
        setState(() {
          isLoading = false ;
        });
      }

    });
  }

  Future<void> removeFromCart(int index) async{
    setState(() {
      isLoading =true ;
    });
    var parms = {
      'user_id': userid,
      'cart_item_id': cartList[index].id.toString()
    };
    apiBaseHelper.postAPICall(removeCartUrl, parms).then((getData) {
      bool status = getData['status'];
      String msg = getData['message'];
      if(status){
        customSnackbar(context, msg);
        cartList.removeAt(index);
        setState(() {
          isLoading =false ;
        });
      }else {
        setState(() {
          isLoading = false ;
        });
        customSnackbar(context, msg);
      }

    });
  }

  Future<void> placeOrderRequest() async{
setState(() {
  isPlaceOrder= true;
});
    var parms = {
      'user_id': userid,
      'order_date': DateTime.now().toString()

    };
    apiBaseHelper.postAPICall(placeOrderUrl, parms).then((getData) {
      bool status = getData['status'];
      String msg = getData['message'];
      if(status){
        customSnackbar(context, msg) ;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankyouScreen()));
        setState(() {
          isPlaceOrder= false;
        });
      }else {
        customSnackbar(context, msg) ;
        setState(() {
          isPlaceOrder= false;
        });
      }

    });
  }


 Widget productCardWidget() {
    return GridView.builder(
        clipBehavior: Clip.antiAlias,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 0,
          childAspectRatio: 0.5,
        ),
        itemCount: cartList.length ,
        itemBuilder: (context,index){
          var item = cartList[index];
          return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(

                  padding: const EdgeInsets.fromLTRB(8,8,4,8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: const Color(0XFFFF4806)
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset:const  Offset(0, 2)
                        )
                      ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: SizedBox(height: 120,child: Image.network(item.image ?? '',fit: BoxFit.cover,))),
                      const SizedBox(height: 8,),
                       Text(item.title.toString().capitalize() ?? '',style: const TextStyle(color: Color(0XFF24253D),fontSize: 16,fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                           Text("Quantity: ${item.quantity}",style: TextStyle(color: Color(0XFF24253D),fontSize: 16,)),
                          /*Row(
                            children: [
                              const Text('4.0',style: TextStyle(color: Color(0XFF24253D),fontSize: 12,)),
                              const SizedBox(width: 0,),
                              Icon(Icons.star,size: 14,color: const Color(0XFFE3CE13),),
                              Icon(Icons.star,size: 14,color: const Color(0XFFE3CE13),),
                              Icon(Icons.star,size: 14,color: const Color(0XFFE3CE13),),
                              Icon(Icons.star,size: 14,color: const Color(0XFFE3CE13),),
                              Icon(Icons.star,size: 14,color: const Color(0XFFE3CE13),),

                            ],
                          )*/

                        ],),
                      Text("Seller: ${item.sellerName}",style: TextStyle(color: Color(0XFF24253D),fontSize: 16,)),

                      const SizedBox(height: 8,),
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            removeFromCart( index);
                          },
                          child: Container(
                            padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: const Color(0XFFFF4806)
                              ),
                            ),
                            child:  const Text('Remove',style: TextStyle(color: Color(0XFF24253D),fontSize: 16,fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(8),bottomLeft:  Radius.circular(8)),
                    border: Border.all(
                        color: const Color(0XFFFF4806)
                    ),
                  ),
                  child: const Icon(Icons.favorite,color: Color(0XFFFF4806) ,),
                )*/
              ]

          );
        });
  }




}




