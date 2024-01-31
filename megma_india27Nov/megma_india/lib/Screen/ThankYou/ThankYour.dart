  import 'package:flutter/material.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Screen/Dashboard/dashboardScreen.dart';
import 'package:megma_india/Widget/custom_app_button.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({Key? key}) : super(key: key);

  @override
  State<ThankyouScreen> createState() => _thankyou_pageState();
}

class _thankyou_pageState extends State<ThankyouScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              const Image(image: AssetImage('assets/images/thankYouImage.png'),height: 80,width: 80,),

              SizedBox(height: 20,),
              const Text(
                "Thank You",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry's Standard Dummy Text Ever Since The 1500S,",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color: Color(0xff7B7A7A),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                },
                child: CustomButton(textt: 'Back To Home'),
              ),
            ]
        ),
      ),
    );
  }
}