import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:megma_india/Helper/Colors.dart';

import '../../Api services/api_services/apiConstants.dart';
import '../../Model/getprivecyModel.dart';
import '../../Widget/customAppbar.dart';
import 'package:http/http.dart' as http;
class termsAndCondition extends StatefulWidget {
  const termsAndCondition({Key? key}) : super(key: key);

  @override
  State<termsAndCondition> createState() => _termsAndConditionState();
}

class _termsAndConditionState extends State<termsAndCondition> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getterm();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(80),
                child:

                CustomAppbar(
                  textt: "Terms & Conditions",
                )),
            body:





            !isloading?


            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title:

                    Row(
                      children: [
                        SizedBox(width: 15,),
                        Text(
                          "Our Terms & Conditions",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // subtitle: Text(
                    //   "Last update january 2022",
                    //   style: TextStyle(fontSize: 10),
                    // ),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey,

                      boxShadow: [
                        BoxShadow(
                          blurRadius: 25.0,
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 15,top: 15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,

                      itemBuilder: (context, index) {
                        return     Column(children: [


                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  '${index+1}. ${getPrivecyModel?.data[1].title??''}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:
                            Html(
                              data:'${getPrivecyModel?.data[1].content??''}',
                            ),
                          ),
                        ],);



                      },),
                  ),



                ],
              ),
            ):
            Container(height: MediaQuery.of(context).size.height,

              width: MediaQuery.of(context).size.width,

              child: Center(child: CircularProgressIndicator(color: AppColors.secondary,),),
            )


        )
    );
  }



  GetPrivecyModel?getPrivecyModel;
  bool isloading=false;
  Future<void> getterm() async {
    setState(() {

      isloading=true;
    });

    var request = http.Request('GET', Uri.parse('${baseUrl}policies?slug='));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result=await response.stream.bytesToString();
      var finalresult=jsonDecode(result);

      if(finalresult['status']){

        setState(() {


          setState(() {
            getPrivecyModel=GetPrivecyModel.fromJson(finalresult);
          });
          setState(() {

            isloading=false;
          });
        });


      }
    }
    else {
      print(response.reasonPhrase);
    }

  }
}

