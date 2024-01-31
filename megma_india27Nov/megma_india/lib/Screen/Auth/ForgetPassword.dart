import 'package:flutter/material.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Screen/Auth/signup_company_details.dart';
import 'package:megma_india/Screen/Auth/verifyScreen.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
import '../../Widget/customfunctionfor_Tostmasg.dart';
import 'brandScreen.dart';
class Foergetpassword extends StatefulWidget {
  const Foergetpassword({Key? key}) : super(key: key);

  @override
  State<Foergetpassword> createState() => _FoergetpasswordState();
}

class _FoergetpasswordState extends State<Foergetpassword> {
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
                Text('Forgot Password',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.secondary,fontSize: 25),),
                SizedBox(height: 20,),



                TextfieldEmailphone(controllerfield:emailcontroller,hinttext: "Email/Mobile Number",itemcount: 50,validation: "Please Enter Email/Mobile Number",imagedataa:"assets/images/EMAIL MOBILE NUMBER.png",),

                SizedBox(height: 80,),

                InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => BrandScreen(),));
                      //
                      if(_formKey.currentState!.validate()){
                        forgetPassword();

                      }


                    },
                    child: CustomButton(textt: "Submit")),

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

  TextEditingController emailcontroller =TextEditingController();

  void forgetPassword(){

    var param = {

      'username': emailcontroller.text.toString(),

    };


    apiBaseHelper.postAPICall(forgetPasswordUrl, param).then((getData) {

        bool error = getData['status'];
        String msg = getData['message'];
        String otpp = getData['otp'].toString();


      if (error) {

        setState(() {
          customSnackbar(context,msg.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => Verify_Screen(otp:otpp.toString(),emailPhone: emailcontroller.text.toString(), ),));


        });



      } else {
setState(() {
  customSnackbar(context,msg.toString());

});

      }

    });


  }

}
