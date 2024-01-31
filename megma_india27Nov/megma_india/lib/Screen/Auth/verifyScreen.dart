import 'package:flutter/material.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Screen/Auth/signup_company_details.dart';
import 'package:megma_india/Screen/Auth/updatepassword.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
import '../../Widget/customfunctionfor_Tostmasg.dart';
import 'ForgetPassword.dart';
class Verify_Screen extends StatefulWidget {
  String ?otp;
  String?emailPhone;
  Verify_Screen({Key? key,this.otp,this.emailPhone}) : super(key: key);

  @override
  State<Verify_Screen> createState() => _Verify_ScreenState();
}

class _Verify_ScreenState extends State<Verify_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      otpp=widget.otp.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: SingleChildScrollView(
        child: Column(children: [
          Container(height: MediaQuery.of(context).size.height/3.5,

            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(


                gradient:RadialGradient(colors:

                [AppColors.primary,AppColors.secondary]

                ) ,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(25))),
            child: Center(child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/signupbanner.png'),fit: BoxFit.cover)),
            ),),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Form(
              key: _formKey,
              child: Column(children: [





                SizedBox(height: 20,),
                Text('Verification',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.secondary,fontSize: 25),),
                SizedBox(height: 15,),
                Text('Code has sent to',style: TextStyle(fontSize: 17),),
SizedBox(height: 3,),
                Text('Email/Mobile Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                Text('${widget.emailPhone.toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                Text('OTP : ${otpp.toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                SizedBox(height: 30,),




                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: OTPTextField(
                    controller: otpController,
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 50,
                    style: const TextStyle(color: AppColors.fieldTextColors),
                    textFieldAlignment: MainAxisAlignment.spaceEvenly,
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) {
                      print("Completed: " + pin);

                      setState(() {
                        otpInput=pin;
                        print(otpInput);
                      });
                    },
                  ),
                ),
SizedBox(height: 10,),

                Text("Haven't received the verification code?",style: TextStyle(fontSize: 17),),

                InkWell(
                   onTap: () {

                     Resendotp();
                   },

                    child: Text('Resend',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),)),
                SizedBox(height: 80,),

                InkWell(
                    onTap: () {


                    if(otpInput==otpp)
                      {

                        verifi();
                      }else{

                      customSnackbar(context,'Please Fill OTP Fields');


                    }


                    },
                    child: CustomButton(textt: "Verify")),

                SizedBox(height: MediaQuery.of(context).size.height/7,),


                SizedBox(height: 20,),

              ],),
            ),
          ),
        ]),
      ),
    ));
  }
  final _formKey = GlobalKey<FormState>();

  OtpFieldController otpController = OtpFieldController();
  var otpInput;
  var otpp;
  void verifi(){

    var param = {

      'username': widget.emailPhone.toString(),
      'otp': otpInput.toString(),

    };


    apiBaseHelper.postAPICall(veryfieUrl, param).then((getData) {

      bool error = getData['status'];
      String msg = getData['message'];
      String otpp = getData['otp'].toString();


      if (error) {

        setState(() {
          customSnackbar(context,msg.toString());
           Navigator.push(context, MaterialPageRoute(builder: (context) => Updatepassword(),));


        });



      } else {
        setState(() {
          customSnackbar(context,msg.toString());

        });

      }

    });


  }



  void Resendotp(){

    var param = {

      'username': widget.emailPhone.toString(),

    };


    apiBaseHelper.postAPICall(forgetPasswordUrl, param).then((getData) {

      bool error = getData['status'];
      String msg = getData['message'];



      if (error) {

        setState(() {
          customSnackbar(context,msg.toString());

          setState(() {
            otpp = getData['otp'].toString();
          });

        });



      } else {

      }

    });


  }


}
