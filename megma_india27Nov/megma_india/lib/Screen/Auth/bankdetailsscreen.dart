import 'package:flutter/material.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Screen/Auth/login_scr.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
import '../../Widget/customfunctionfor_Tostmasg.dart';
class BankdetailsScr extends StatefulWidget {

  String ?name;
  String ?email;
  String ?mobile;
  String ?companyname;
  String ?designation;
  String ?role;
  String?comaddress;
  String?comstate;
  String?comcity;
  String?comarea;
  String?compincode;
  String?combuildingNo;
  String?adhar;
  String?pan;
  String?gst;
  String?currentphysicaladdress;
  String?password;
  String?lat;
  String?lang;

  BankdetailsScr({Key? key,this.lang,this.lat,this.name,this.email,this.mobile,this.companyname,this.designation,this.role,this.comaddress,this.comstate,this.comarea,this.comcity,this.compincode,this.combuildingNo,this.adhar,this.pan,this.gst,this.currentphysicaladdress,this.password}) : super(key: key,);

  @override
  State<BankdetailsScr> createState() => _BankdetailsScrState();
}

class _BankdetailsScrState extends State<BankdetailsScr> {

  @override
  void initState() {
    // TODO: implement initState

    print('${widget.role}');

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: SingleChildScrollView(
        child: Column(children: [


          Container(height: 80,

            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(


                gradient:RadialGradient(colors:

                [AppColors.primary,AppColors.secondary]

                ) ,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
            child: Center(child:

            Text('Account Details',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whiteTemp,fontSize: 20),),

            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Form(
              key: _formKey,
              child: Column(children: [


SizedBox(height: 10,),



                CustomTemtextField(
                    controllerfield: banknamecontroller,
                    hinttext: "Bank Name",
                    itemcount: 20,

                    imagedataa: "assets/images/COMPANY NAME.png"),

                SizedBox(height: 10,),




                  CustomTemtextField(
                      controllerfield: accountholdernamecontroller,
                      hinttext: "Account Holder Name",
                      itemcount: 30,
                      imagedataa: "assets/images/COMPANY NAME.png"),
                  SizedBox(height: 10,),


                AccountNumber(
                    controllerfield: accountnumbercontroller,
                    hinttext: "Account Number",
                    itemcount: 30,
                    imagedataa: "assets/images/COMPANY NAME.png"),

                SizedBox(height: 10,),


                textfieldIFSC(
                    controllerfield:ifsccontroller ,
                    hinttext: "IFSC Code",

                    imagedataa: "assets/images/COMPANY NAME.png"),

                SizedBox(height: 10,),


                CustomTemtextField(
                    controllerfield: upicontroller,
                    hinttext: "UPI Id",
                    itemcount: 30,
                    imagedataa: "assets/images/COMPANY NAME.png"),


                SizedBox(height: 50,),

                InkWell(
                    onTap: () {
                      // if(_formKey.currentState!.validate()){

                        ragistrationApi();

                      // }


                    },
                    child: CustomButton(textt: "Next")),


                SizedBox(height: 20,),

              ],),
            ),
          ),
        ]),
      ),
    ));
  }
  final _formKey = GlobalKey<FormState>();
  TextEditingController banknamecontroller =TextEditingController();
  TextEditingController accountholdernamecontroller =TextEditingController();
  TextEditingController accountnumbercontroller=TextEditingController();
  TextEditingController ifsccontroller=TextEditingController();
  TextEditingController upicontroller=TextEditingController();

  Future <void> ragistrationApi () async{

    var param = {
      'name': widget.name.toString(),
      'email': widget.email.toString(),
      'mobile': widget.mobile.toString(),
      'password': widget.password,
      'role_id': widget.role,
      'company_name': widget.companyname,
      'designation': widget.designation,
      'address': widget.comaddress,
      'lat': widget.lat.toString(),
      'lang': widget.lang.toString(),
      'upi': upicontroller.text.toString(),
      'pancard': widget.pan.toString(),
      'gst': widget.gst.toString(),
      'current_address': widget.currentphysicaladdress.toString(),
      'bankname': banknamecontroller.text.toString(),
      'account_name': accountholdernamecontroller.text.toString(),
      'account_no': accountnumbercontroller.text.toString(),
      'ifsc_code': ifsccontroller.text.toString(),
      'state': widget.comstate,
      'city': widget.comcity,
      'area': widget.comarea,
      'pincode': widget.compincode,
      'building_no': widget.combuildingNo,
      'aadhar': widget.adhar.toString(),
    };


    apiBaseHelper.postAPICall(registerUrl, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {

        setState(() {
          customSnackbar(context,msg.toString());


        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login_Screen()),
                (Route<dynamic> route) => false);
        });
      } else {
        setState(() {
          customSnackbar(context,msg.toString());


          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login_Screen()),
                  (Route<dynamic> route) => false);
        });

      }

    });
  }
}
