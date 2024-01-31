import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Model/getbrands.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({Key? key}) : super(key: key);

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBrand();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: PreferredSize(preferredSize: 
      Size.fromHeight(80),
      child:

      Container(height: 80,

        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(


            gradient:RadialGradient(colors:

            [AppColors.primary,AppColors.secondary]

            ) ,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
        child: Center(child:

        Text('Brands',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whiteTemp,fontSize: 20),),

        ),
      ),
      ),
      body:


      !isloading?
      Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(child: Column(children: [

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: getBrands?.data.length??0,

            itemBuilder: (context, index) {

            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(height: 110,
width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.secondary)

              ),
child: Row(children: [

  Padding(
    padding: const EdgeInsets.all(5),
    child: Container(height: 110,
    width: 130,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),

          image: DecorationImage(image: NetworkImage('${getBrands?.data[index].image??''}'),fit: BoxFit.fill)),
    ),
  ),
SizedBox(width: 10,),
  Text('${getBrands?.data[index].title??''}',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.blackTemp,fontSize: 18),),

]),
              ),
            );
          },)


        ]),),
      )
      :
          Container(height: MediaQuery.of(context).size.height,

          width: MediaQuery.of(context).size.width,

            child: Center(child: CircularProgressIndicator(color: AppColors.secondary,),),
          )
      
      
      ,));
  }
  GetBrands?getBrands;
bool isloading=false;
  void getBrand(){
    setState(() {

      isloading=true;
    });
    apiBaseHelper.getAPICall(
        getBrandsUrl
    ).then((getData){

      print(getData);
      if (getData['status']) {
        setState(() {


          getBrands=GetBrands.fromJson(getData);
          setState(() {

            isloading=false;
          });
        });

      }
      else {
        print("fghjkkjh");

      }


    },);





  }
}
