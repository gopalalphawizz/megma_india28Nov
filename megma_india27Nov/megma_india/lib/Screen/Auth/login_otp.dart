
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String boolKey = "isUserLoggedIn";
  var myOTP;

  getMobile() async {
    var headers = {
      'Cookie': 'ci_session=b42a59ede22924a7f40bf60f450ead55ac64659e'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/eco_rider/api/Authentication/login'));
    request.fields.addAll({
      'user_phone': mobile.text,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("aaaa1");
      print("mmm");

      var result = await response.stream.bytesToString();
      print("kkk");
      var finaResult = jsonDecode(result);

      print("cccc");
      print(finaResult['status'].toString());
      print(finaResult['data'].toString());

      //bb
      print(mobile.text);
      String mobileNO = mobile.toString();
      var otp = finaResult['data'].toString();

      setState(() {
        myOTP = otp;
      });

      print(otp);
      print("2222222");
      if (finaResult['status'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTPLogin(otp: myOTP, mobile: mobile.text),
          ),
        );
      } else {
        print("invalid no.....");
      }
    } else {
      print("mobile 222");
      print(response.reasonPhrase);
    }
  }

  TextEditingController mobile = TextEditingController();

  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.orange,
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              // width: 100,
              // height: 50,
              child: Image.asset('assets/images/LOGIN.png'),
            ),
        
                Container(
                  height: MediaQuery.of(context).size.height * .7,
                //  margin: EdgeInsets.only(top: 260),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(50),
                      topStart: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 22, right: 22, top: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 0,),
                        Row(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   'There are many variants of passenger...',
                        // ),
                        SizedBox(height: 20,),
                        Form(
                          key: _formKey1,
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                color: Colors.white,
                                elevation: 3,
                                child: Container(
                                  width: 370,
                                  child: TextFormField(
                                    controller: mobile,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Mobile number';
                                      } else if (value.length < 10) {
                                        return 'At least 10 No. requ';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                      Icon(Icons.phone, color: Colors.orangeAccent),
                                      hintText: "Mobile no.",
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(45),
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(45),
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formKey1.currentState!.validate()) {
                                    getMobile();
                                  }
                                },
                                child: Container(
                                  width: 280,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(150)),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.orange.shade400,
                                        Colors.orangeAccent
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Send OTP',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?  ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Sign Up  ",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        
        
          ],
        ),
      ),
      // body: Stack(
      //   children: [
      //     Positioned(
      //       top: 20,
      //       left: 30,
      //       child: Container(
      //         height:100,
      //         color: Colors.orangeAccent,
      //         child: Image.asset('assets/images/LOGIN.png'),
      //       ),
      //     ),
      //     // Container(
      //     //   margin: EdgeInsets.only(top: 250),
      //     //   decoration: BoxDecoration(
      //     //     borderRadius: BorderRadiusDirectional.only(
      //     //       topEnd: Radius.circular(50),
      //     //       topStart: Radius.circular(50),
      //     //     ),
      //     //     color: Colors.black,
      //     //   ),
      //     // ),
      //     // Container(
      //     //   height: MediaQuery.of(context).size.height * .5,
      //     //   margin: EdgeInsets.only(top: 260),
      //     //   decoration: BoxDecoration(
      //     //     color: Colors.white,
      //     //     borderRadius: BorderRadiusDirectional.only(
      //     //       topEnd: Radius.circular(50),
      //     //       topStart: Radius.circular(50),
      //     //     ),
      //     //   ),
      //     //   child: Padding(
      //     //     padding: const EdgeInsets.only(left: 22, right: 22, top: 5),
      //     //     child: Column(
      //     //       children: [
      //     //         SizedBox(height: 20,),
      //     //         Row(
      //     //           children: [
      //     //             Text(
      //     //               "Login",
      //     //               style: TextStyle(
      //     //                 fontWeight: FontWeight.bold,
      //     //                 fontSize: 25,
      //     //               ),
      //     //             ),
      //     //           ],
      //     //         ),
      //     //         // Text(
      //     //         //   'There are many variants of passenger...',
      //     //         // ),
      //     //         Form(
      //     //           key: _formKey1,
      //     //           child: Column(
      //     //             children: [
      //     //               Card(
      //     //                 shape: RoundedRectangleBorder(
      //     //                   borderRadius: BorderRadius.circular(45),
      //     //                 ),
      //     //                 color: Colors.white,
      //     //                 elevation: 3,
      //     //                 child: Container(
      //     //                   width: 370,
      //     //                   child: TextFormField(
      //     //                     controller: mobile,
      //     //                     validator: (value) {
      //     //                       if (value == null || value.isEmpty) {
      //     //                         return 'Enter Mobile number';
      //     //                       } else if (value.length < 10) {
      //     //                         return 'At least 10 No. requ';
      //     //                       }
      //     //                       return null;
      //     //                     },
      //     //                     keyboardType: TextInputType.phone,
      //     //                     decoration: InputDecoration(
      //     //                       prefixIcon:
      //     //                       Icon(Icons.phone, color: Colors.orangeAccent),
      //     //                       hintText: "Mobile no.",
      //     //                       filled: true,
      //     //                       fillColor: Colors.white,
      //     //                       focusedBorder: OutlineInputBorder(
      //     //                         borderRadius: BorderRadius.circular(45),
      //     //                         borderSide: BorderSide(color: Colors.white),
      //     //                       ),
      //     //                       enabledBorder: OutlineInputBorder(
      //     //                         borderRadius: BorderRadius.circular(45),
      //     //                         borderSide: BorderSide(color: Colors.white),
      //     //                       ),
      //     //                     ),
      //     //                   ),
      //     //                 ),
      //     //               ),
      //     //               SizedBox(
      //     //                 height: 50,
      //     //               ),
      //     //               InkWell(
      //     //                 onTap: () {
      //     //                   if (_formKey1.currentState!.validate()) {
      //     //                     getMobile();
      //     //                   }
      //     //                 },
      //     //                 child: Container(
      //     //                   width: 280,
      //     //                   height: 50,
      //     //                   decoration: BoxDecoration(
      //     //                     borderRadius:
      //     //                     BorderRadius.all(Radius.circular(150)),
      //     //                     gradient: LinearGradient(
      //     //                       begin: Alignment.centerLeft,
      //     //                       end: Alignment.centerRight,
      //     //                       colors: [
      //     //                         Colors.orange.shade400,
      //     //                         Colors.orangeAccent
      //     //                       ],
      //     //                     ),
      //     //                   ),
      //     //                   child: Center(
      //     //                     child: Text(
      //     //                       'Send OTP',
      //     //                       style: TextStyle(
      //     //                         fontSize: 18,
      //     //                         color: Colors.white,
      //     //                       ),
      //     //                     ),
      //     //                   ),
      //     //                 ),
      //     //               ),
      //     //               SizedBox(
      //     //                 height: 50,
      //     //               ),
      //     //               Row(
      //     //                 mainAxisAlignment: MainAxisAlignment.center,
      //     //                 children: [
      //     //                   Text(
      //     //                     "Don't have an account?  ",
      //     //                     style: TextStyle(color: Colors.black),
      //     //                   ),
      //     //                   Text(
      //     //                     "Sign Up  ",
      //     //                     style: TextStyle(color: Colors.orange),
      //     //                   ),
      //     //                 ],
      //     //               )
      //     //             ],
      //     //           ),
      //     //         ),
      //     //       ],
      //     //     ),
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}




// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../main.dart';
// import 'otp_screen.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
//
//
//   final String boolKey = "isUserLoggedIn"; // Key for storing boolean value
//
//   var myOTP;
//   getMobile()
//   async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     var headers = {
//       'Cookie': 'ci_session=b42a59ede22924a7f40bf60f450ead55ac64659e'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/eco_rider/api/Authentication/login'));
//     request.fields.addAll({
//       'user_phone': mobile.text
//     });
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print("aaaa1");
//       // print(await response.stream.bytesToString());
//       print("mmm");
//       print(mobile.text);
//
//       var result = await response.stream.bytesToString();
//       print("kkk");
//       var finaResult = jsonDecode(result);
//       print("cccc");
//       print(finaResult['status'].toString());
//       print(finaResult['data'].toString());
//
//       //bb
//       print(mobile.text);
//       String mobileNO=mobile.toString();
//       var otp=finaResult['data'].toString();
//
//       setState(() {
//         myOTP=otp;
//       });
//
//       print(otp);
//       print("2222222");
//       if(finaResult['status']==true) {
//
//         Navigator.pushReplacement(context, MaterialPageRoute(
//             builder: (context) => OTPLogin(otp: myOTP, mobile: mobile.text)));
//       }
//       else
//       {
//         print("invalid no.....");
//       }
//     }
//     else {
//       print("mobile 222");
//       print(response.reasonPhrase);
//     }
//
//   }
//
//   Future<void> getApi()
//   async {
//     var headers = {
//       'Cookie': 'ci_session=b42a59ede22924a7f40bf60f450ead55ac64659e'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/eco_rider/api/Authentication/login'));
//     request.fields.addAll({
//       'email': email.text,
//       'password': password.text
//     });
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print("aaaa1");
//       print("mmm");
//
//       var result = await response.stream.bytesToString();
//       print("kkk");
//       var finaResult = jsonDecode(result);
//
//       print("cccc");
//       print(finaResult['status'].toString());
//       if( finaResult['status']==true) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setBool(boolKey, true);
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => HomeScreen()),
//         // );
//       }
//     }
//     else {
//       print("bbbb1");
//       print(response.reasonPhrase);
//     }
//
//   }
//
//   late TabController tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//   }
//
//
//   final _formKey = GlobalKey<FormState>();
//   final _formKey1 = GlobalKey<FormState>();
//   var email = TextEditingController();
//   var password = TextEditingController();
//   TextEditingController mobile=TextEditingController();
//
//   bool isVisible = true;
//
//
//   String? _validateEmail(value) {
//     if (value!.isEmpty) {
//       return "Please enter an email";
//     }
//     RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegExp.hasMatch(value)) {
//       return "Please enter a valid email";
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     mq = MediaQuery.of(context).size;
//   // var mq;
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//           body: Stack(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 color: Colors.orangeAccent,
//
//                 child: Stack(
//
//                     children:[ Positioned(
//                         height: mq.height * .35,
//                         width: mq.width * .5,
//
//                         right: mq.width * .25 ,
//
//                         child: Image.asset('assets/images/LOGIN.png')),]
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 250),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadiusDirectional.only(
//                     topEnd: Radius.circular(50),
//                     topStart: Radius.circular(50),
//                   ),
//                   color: Colors.black,
//                 ),
//               ),
//               SingleChildScrollView(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height,
//                   margin: EdgeInsets.only(top: 260),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadiusDirectional.only(
//                       topEnd: Radius.circular(50),
//                       topStart: Radius.circular(50),
//                     ),
//
//
//                   ),
//
//                   child:Padding(
//                     padding: const EdgeInsets.only(left: 22,right: 22, top: 5),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
//                           ],
//                         ),
//                         Text('There are many variants of passenger There are many variants of passenger There are many variants of passenger There are many variants of passenger .'),
//
//                         TabBar(
//                           controller: tabController,
//                           isScrollable: true,
//                           labelColor: Colors.black,
//                           tabs: const [
//                             Tab(
//                               child:Row(
//                                 children: [
//                                   Icon(Icons.circle_outlined,color: Colors.orangeAccent,),
//                                   Text('Mobile')
//                                 ],
//
//                               ) ,
//                             ),
//                             Tab(
//                               child:Row(
//                                 children: [
//                                   Icon(Icons.circle_outlined,color: Colors.orangeAccent,),
//                                   Text('Email')
//                                 ],
//                               ) ,
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             controller: tabController,
//                             children: [
//
//                               Form(
//                                 key: _formKey1,
//                                 child: Column(
//                                   children: [
//                                     Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(45),
//                                       ),
//                                       color: Colors.white,
//                                       elevation: 3,
//                                       child: Container(
//                                         width: 370,
//                                         child: TextFormField(
//                                           controller: mobile,
//                                           validator: (value) {
//                                             if (value == null || value.isEmpty) {
//                                               return 'Enter Mobile number';
//                                             } else if (value.length < 10) {
//                                               return 'At least 10 No. requ';
//                                             }
//                                             return null;
//                                           },
//                                           keyboardType: TextInputType.phone,
//                                           decoration: InputDecoration(
//                                             prefixIcon: Icon(Icons.phone, color: Colors.orangeAccent),
//                                             hintText: "Mobile no.",
//                                             filled: true,
//                                             fillColor: Colors.white,
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(45),
//                                               borderSide: BorderSide(color: Colors.white),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(45),
//                                               borderSide: BorderSide(color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                     SizedBox(
//                                       height: 50,
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         if (_formKey1.currentState!.validate()) {
//                                           getMobile();
//                                           //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OTPLogin()));
//                                         }
//                                       },
//                                       child: Container(
//                                         width: 280,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(Radius.circular(150)),
//                                           gradient: LinearGradient(
//                                             begin: Alignment.centerLeft,
//                                             end: Alignment.centerRight,
//                                             colors: [Colors.orange.shade400, Colors.orangeAccent],
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'Send OTP',
//                                             style: TextStyle(fontSize: 18, color: Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 50,),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//
//                                         Text("Don't have an account?  ",style: TextStyle(color: Colors.black),),
//                                         Text("Sign Up  ",style: TextStyle(color: Colors.orange),),
//                                       ],
//                                     )
//
//
//                                   ],
//                                 ),
//                               ),
//                               Form(
//                                 key: _formKey,
//                                 child: Column(
//                                   children: [
//                                     Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(45),
//                                       ),
//                                       color: Colors.white,//no use
//                                       elevation: 3,
//                                       child: Container(
//                                         width: 370,
//                                         child: TextFormField(
//                                           controller: email,
//                                           validator: _validateEmail,
//                                           keyboardType: TextInputType.emailAddress,
//                                           decoration: InputDecoration(
//                                             prefixIcon: Icon(Icons.email, color: Colors.orangeAccent),
//                                             hintText: "Email",
//                                             filled: true,
//                                             fillColor: Colors.white,
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(45),
//                                               borderSide: BorderSide(color: Colors.white),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(45),
//                                               borderSide: BorderSide(color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(45),
//                                       ),
//                                       color: Colors.white,
//                                       elevation: 3,
//                                       child: Container(
//                                         width: 370,
//                                         child: TextFormField(
//                                           controller: password,
//                                           validator: (value) {
//                                             if (value == null || value.isEmpty) {
//                                               return 'Enter password';
//                                             } else if (value.length < 6) {
//                                               return 'At least 6 characters required';
//                                             }
//                                             return null;
//                                           },
//                                           obscureText: isVisible ? false : true,
//                                           keyboardType: TextInputType.text,
//                                           decoration: InputDecoration(
//                                             suffixIcon: IconButton(
//                                               onPressed: () {
//                                                 setState(() {
//                                                   isVisible ? isVisible = false : isVisible = true;
//                                                 });
//                                               },
//                                               icon: Icon(
//                                                 isVisible ? Icons.remove_red_eye : Icons.visibility_off,
//                                                 color: Colors.orangeAccent,
//                                               ),
//                                             ),
//                                             prefixIcon: Icon(Icons.phone, color: Colors.orangeAccent),
//                                             hintText: "Password",
//                                             filled: true,
//                                             fillColor: Colors.white,
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(45),
//                                               borderSide: BorderSide(color: Colors.white),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(45),
//                                               borderSide: BorderSide(color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         TextButton(onPressed: (){}, child: Text('Forgot Password?',style: TextStyle(color: Colors.orange),)),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 50,
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         if (_formKey.currentState!.validate()) {
//                                           getApi();
//                                         }
//                                       },
//                                       child: Container(
//                                         width: 280,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(Radius.circular(150)),
//                                           gradient: LinearGradient(
//                                             begin: Alignment.centerLeft,
//                                             end: Alignment.centerRight,
//                                             colors: [Colors.orange.shade400, Colors.orangeAccent],
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'Login',
//                                             style: TextStyle(fontSize: 18, color: Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 50,),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//
//                                         Text("Don't have an account?  ",style: TextStyle(color: Colors.black),),
//                                         Text("Sign Up  ",style: TextStyle(color: Colors.orange),),
//                                       ],
//                                     )
//
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//             ],
//           )
//       ),
//     );
//   }
// }
//
