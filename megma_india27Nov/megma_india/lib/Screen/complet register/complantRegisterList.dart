import 'package:flutter/material.dart';
import 'package:megma_india/Api%20services/api_services/apiBasehelper.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Screen/Privecy%20Policy/privecyPolicy.dart';
import 'package:megma_india/Screen/upload%20document/uploadeddetails.dart';
import 'package:megma_india/Widget/customAppbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/getComplantregisterList.dart';
import '../../Model/getUploaddedModel.dart';

class ComplantListScre extends StatefulWidget {
  const ComplantListScre({Key? key}) : super(key: key);
  @override
  State createState() => _ComplantListScreState();
}

class _ComplantListScreState extends State {




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar:
          PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: CustomAppbar(
                textt: "My Installation",
              )),
          body:

          !isLoading?

          uploadedList.isNotEmpty?
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: 55,
              itemBuilder: (context, index) {
                return


                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UploadedDetails(UploadeddataId: uploadedList[index].id.toString(),)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(

                        height: 200,


                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),

                            border: Border.all(color: AppColors.secondary)
                        ),


                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(


                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Text("Installation Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Divider(color: AppColors.secondary,height: 2),

                                Row(children: [

                                  Text("Installation Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Spacer(),
                                  Text("12-23-3023",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                ],),

                                Row(children: [

                                  Text("Installation Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Spacer(),
                                  Text("12-23-3023",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                ],),
                                Row(children: [

                                  Text("Installation Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Spacer(),
                                  Text("12-23-3023",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                ],),
                                Row(children: [

                                  Text("Installation Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Spacer(),
                                  Text("12-23-3023",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                ],),
                                Row(children: [

                                  Text("Installation Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Spacer(),
                                  Text("12-23-3023",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                ],),

                              ]),
                        ),
                      ),
                    ),
                  );

              },),
          ):


          Container(height: MediaQuery.of(context).size.height/1.2,width: MediaQuery.of(context).size.width,


            child: Center(child: Text("Data Not Found"),),

          ):


          Container(height: MediaQuery.of(context).size.height/1.2,width: MediaQuery.of(context).size.width,


            child: Center(child: LoadingWidget2(context),),
          )

      ),
    );
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getUpdodeddata();

  }
  bool isLoading=false;
  List<ComplantListModel> uploadedList=[];
  Future<void> getUpdodeddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userId').toString();
    setState(() {
      isLoading=true;
    });
    var param={



      'user_id':userid.toString(),

    };
    apiBaseHelper.postAPICall(addclamListUrl, param).then((getData){
      bool error=getData['status'];
      String msg=getData['message'];
      if(error==true){

        uploadedList=GetComplantRegisterList.fromJson(getData).data??[];

        setState(() {
          isLoading=false;
        });
      }else{

        setState(() {
          isLoading=false;
        });
      }


    });

  }

}
