
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:megma_india/Screen/Auth/login_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/login_scr.dart';
import '../Dashboard/dashboardScreen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? uid;
  String? type;
  bool? isSeen;
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

    ]);
     checkLogin ();
    // checkinternetconnection();
    super.initState();
  }

  checkLogin () async{
    Timer(const Duration(seconds: 3),() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String isLogin =  prefs.getString('userId').toString();
print("sessionId=============${isLogin.runtimeType}");
print("sessionId=============${isLogin}");
      if(isLogin=="null"){

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>LoginScreen()),
                (Route<dynamic> route) => false);
 // Navigator.of(context).pushAndRemoveUntil(
 //            MaterialPageRoute(builder: (context) => Login_Screen()),
 //                (Route<dynamic> route) => false);

      }else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Dashboard()),
                (Route<dynamic> route) => false);



      }
    });
  }

  Future<void> checkinternetconnection() async {

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        checkLogin();
        print(' connected');
        Navigator.push(context,MaterialPageRoute(builder: (context) => Login_Screen(),));
      }
    } on SocketException catch (_) {

      print('not connected');

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,

        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/splash.png'),fit: BoxFit.cover,)

        ),


      ),
    );
  }
}