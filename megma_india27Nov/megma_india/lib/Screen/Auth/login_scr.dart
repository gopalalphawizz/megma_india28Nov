import 'package:flutter/material.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Screen/Auth/signup_company_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/loadingwidget.dart';
import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
import '../../Widget/customfunctionfor_Tostmasg.dart';
import '../Dashboard/dashboardScreen.dart';
import 'ForgetPassword.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [AppColors.primary, AppColors.secondary]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(25))),
            child: Center(
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loginbanner.png'),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextfieldEmailphone(
                    controllerfield: emailcontroller,
                    hinttext: "Email/Mobile Number",
                    itemcount: 50,
                    validation: "Email/Mobile Number",
                    imagedataa: "assets/images/EMAIL MOBILE NUMBER.png",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Textfieldpassword(
                    controllerfield: passwordcontroller,
                    hinttext: "Password",
                    itemcount: 50,
                    validation: "Please Enter Password",
                    imagedataa: "assets/images/PASSWORD.png",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Foergetpassword(),
                                ));
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                                fontSize: 15),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child:

                      !isLoading?
                      CustomButton(textt: "Login"):LoadingWidget(context)



                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signup_company_scr(),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackTemp,
                                fontSize: 17),
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                                fontSize: 17),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }

  final _formKey = GlobalKey<FormState>();
bool isLoading=false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void login() {
    setState(() {
      isLoading=true;
    });
    var param = {
      'username': emailcontroller.text.toString(),
      'password': passwordcontroller.text.toString(),
    };

    apiBaseHelper.postAPICall(loginUrl, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        print(getData['user']['id']);
        print(getData['user']['role']);
        setState(() async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', getData['user']['id'].toString());
          await prefs.setString('role', getData['user']['role'].toString());

          customSnackbar(context, msg.toString());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ));
        });

        setState(() {
          isLoading=true;
        });
      } else {
        customSnackbar(context, msg.toString());
        setState(() {
          isLoading=true;
        });
      }
    });
  }
}
