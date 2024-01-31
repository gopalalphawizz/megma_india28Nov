import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class OTPLogin extends StatefulWidget {
  final String otp;
  final String mobile;

  const OTPLogin({Key? key, required this.otp, required this.mobile}) : super(key: key);

  @override
  State<OTPLogin> createState() => _OTPLoginState();
}

class _OTPLoginState extends State<OTPLogin> {

  final String boolKey = "isUserLoggedIn"; // Key for storing boolean value


  otpVerify()
  async {
    var headers = {
      'Cookie': 'ci_session=a30ce070713a88d1579a371f475a74d857cc67bf'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/eco_rider/api/Authentication/otp_varify'));
    request.fields.addAll({
      'user_phone': widget.mobile,
      'otp': otpController.text
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("kkkkOTP");
      // print(await response.stream.bytesToString());


      var result = await response.stream.bytesToString();
      print("kkk");
      var finaResult = jsonDecode(result);
      print("cccc");
      print(finaResult['status'].toString());
      print(finaResult['data'].toString());

      if(finaResult['status']==true) {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool(boolKey, true);
      }
      else
      {
        print("invalid otp number");
      }
    }
    else {
      print("invalid otp .......");
      print(response.reasonPhrase);
    }

  }
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Set the initial value of the otpController with the provided OTP
    otpController.text = widget.otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Column(
        children: [
          SizedBox(height: 30,),
          Row(
                children: [
                  SizedBox(width: 15,),
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                  ),
                  SizedBox(width: 70,),
                  Text("Verification", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                ],
              ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('There are many variants of passenger. There are many variants of passenger. There are many variants of passenger. There are many variants of passenger.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),

          SizedBox(height: 50,),
          // Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: double.infinity,
          //   color: Colors.orangeAccent,
          //   child: Column(
          //     children: [
          //       SizedBox(height: 30,),
          //       Row(
          //         children: [
          //           SizedBox(width: 15,),
          //           InkWell(
          //             onTap: (){
          //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          //             },
          //             child: Icon(Icons.arrow_back_ios, color: Colors.white,),
          //           ),
          //           SizedBox(width: 70,),
          //           Text("Verification", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
          //         ],
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
          //         child: Text('There are many variants of passenger. There are many variants of passenger. There are many variants of passenger. There are many variants of passenger.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 293),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadiusDirectional.only(
          //       topEnd: Radius.circular(50),
          //       topStart: Radius.circular(50),
          //     ),
          //     color: Colors.black,
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(50),
                topStart: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text("Code has sent to", style: TextStyle(fontSize: 20, color: Colors.grey)),
                Text("+91 ${widget.mobile}", style: TextStyle(fontSize: 20)),

                // Replace four separate containers with PinCodeTextField
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: PinCodeTextField(

                    appContext: context,
                    length: 4,
                    onChanged: (value) {
                      // Handle OTP input changes
                    },
                    controller: otpController,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      selectedColor: Colors.black,
                      borderWidth: 2,

                    ),
                  ),
                ),

                // Haven't received the verification code and Resend text
                Text("Haven't received the verification code?", style: TextStyle(fontSize: 15)),
                Text("Resend", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),

                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    otpVerify();
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                  child: Container(
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(150)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.orange.shade400, Colors.orangeAccent],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
