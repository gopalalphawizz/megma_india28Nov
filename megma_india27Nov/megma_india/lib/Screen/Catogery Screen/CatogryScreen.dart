

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/getCatModel.dart';
import '../../Widget/customAppbar.dart';
import '../../Widget/custom_app_button.dart';
import '../Receieve Enquiry/receieve_enquiery.dart';
import '../ScannerScreen/scannerScreen.dart';
import '../Sub Cat/sub_cat_screen.dart';
import '../upload document/upload_document.dart';

class Category_Screen extends StatefulWidget {
  const Category_Screen({super.key});

  @override
  State<Category_Screen> createState() => _Category_ScreenState();
}

class _Category_ScreenState extends State<Category_Screen> {
  late Future<dynamic> futureCatData ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserid();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:


        PreferredSize(
            preferredSize: Size.fromHeight(80),
            child:

            Container(height: 80,

            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(


            gradient:RadialGradient(colors:

            [AppColors.primary,AppColors.secondary]

            ) ,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
            child: Center(child:

            // role=="4"||role=="5"||role=="6"?
            // Text('Scanner',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whiteTemp,fontSize: 20),):
            Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whiteTemp,fontSize: 20),),

      ),
      ),
        ),
        body:
        !isloading?

        Padding(
          padding:  EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
          child:

        // role=="6"?Scanner(context):
        //

                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 16
                      ),
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: catogryList.length,
                      itemBuilder: (context, index){

                        return


                          InkWell(
                            onTap: () {


                              Navigator.push(context, MaterialPageRoute(builder: (context) => Sub_Category_Screen(getCatogryModel: getCatogryModel, indexx: index),));

                            },
                            child: Column(
                            children: [

                              Container(height: 60,

                                width: 60,
                                decoration:   BoxDecoration(shape: BoxShape.circle,

                                    color: AppColors.secondary,
                                    image: DecorationImage(image:NetworkImage(catogryList[index].image.toString()),fit: BoxFit.fill )
                                ),
                              ),

                              const SizedBox(

                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child:   Text(
      catogryList[index].title.toString(),
                                  style: const TextStyle(fontSize: 14,),
                                  maxLines: 1,
                                ),
                              )
                            ],
                        ),
                          ) ;
                      })






        ):


  Container(height: MediaQuery.of(context).size.height,

  width: MediaQuery.of(context).size.width,

  child: Center(child: LoadingWidget2(context),),
  )
      ),
    );
  }

bool isloading=false;
GetCatogryModel?getCatogryModel;
List<Getcat> catogryList=[];
Future<void> getcat() async {
  setState(() {
    isloading=true;
  });
  apiBaseHelper.getAPICall(
      getcatogryUrl
  ).then((getData){


    if (getData['status']) {
      setState(() {

        getCatogryModel= GetCatogryModel.fromJson(getData);



        for(int i=0;i<getCatogryModel!.data.length;i++){

          setState(() {
            catogryList.add(getCatogryModel!.data[i]);
          });

        }

        print("============${catogryList.length}");
        setState(() {
          isloading=false;
        });
      });

    }
    else {

    }


  },);


}
  String? role ;

  Future<void> getuserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    role = prefs.getString('role').toString();
setState(() {

});

      getcat();
      setState(() {

      });


  }


}



