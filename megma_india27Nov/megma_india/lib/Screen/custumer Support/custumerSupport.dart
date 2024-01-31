import 'package:flutter/material.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Widget/custom_app_button.dart';
import '../../Widget/customAppbar.dart';
import '../../Widget/customTextField.dart';


class custmerSupport extends StatefulWidget {
  const custmerSupport({Key? key}) : super(key: key);

  @override
  State<custmerSupport> createState() => _custmerSupportState();
}

class _custmerSupportState extends State<custmerSupport> {
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(

          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child:

              CustomAppbar(
                textt: "Customer Support",

              )),
          body:

          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(

                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(

                          // shape: BoxShape.circle,


                      image: DecorationImage(image: AssetImage('assets/images/supportIcon.png'),
                      fit: BoxFit.fill
                      )

                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'How Can We Help You?',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the',
                        style: TextStyle(fontSize: 15,color: AppColors.supportTextcolor),
                      ),
                    ),

                    Center(
                      child: Text(
                        'printing and typesetting industry.',

                        style: TextStyle(fontSize: 15,color: AppColors.supportTextcolor),                    ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.support_agent,size: 20,color: AppColors.secondary,),
                        SizedBox(width: 5,),
                        Text(
                          '+ 01234567894',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    CustomTemtextField(
                        controllerfield: namecontroller,
                        hinttext: "Replacement, Warrant",
                        itemcount: 50,
                        imagedataa: "assets/images/CONTACT PERSON.png"),
                    SizedBox(height: 8,),
                    CustomTemtextField(
                        controllerfield: namecontroller,
                        hinttext: "Subject",
                        itemcount: 50,
                        imagedataa: "assets/images/CONTACT PERSON.png"),
                    SizedBox(height: 8,),
                    Textfieldonlyemail(
                        controllerfield: emailcontroller,
                        hinttext: "Email",
                        itemcount: 50,
                        imagedataa: "assets/images/EMAIL MOBILE NUMBER.png"),

                    SizedBox(height: 8,),
                    CustomTemtextField(
                        controllerfield: namecontroller,
                        hinttext: "Type your message...",
                        itemcount: 50,
                        imagedataa: "assets/images/CONTACT PERSON.png"),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(height: 40,width: 40,

                        decoration: BoxDecoration(shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage('assets/images/phone-call.png'),fit: BoxFit.fill)



                        ),

                        ),

                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {

                              _formKey.currentState!.save();
                            }

                          },
                          child:

                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width/1.8,

                            decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/(1.5)/2)
                            ),

                            child: Center(child: Text('Send',style: TextStyle(fontWeight: FontWeight.bold,color:AppColors.whiteTemp ),),),
                          ),
                        ),

                        Container(height: 40,width: 40,

                          decoration: BoxDecoration(shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage('assets/images/whatsapp.png'),fit: BoxFit.fill)



                          ),

                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();
}