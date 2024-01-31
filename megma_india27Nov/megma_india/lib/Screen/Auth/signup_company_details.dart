import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Model/getRoleModel.dart';
import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
import 'conpany_details_screen.dart';
import 'kyc_details_scr.dart';

class Signup_company_scr extends StatefulWidget {
  const Signup_company_scr({Key? key}) : super(key: key);

  @override
  State<Signup_company_scr> createState() => _Signup_company_scrState();
}

class _Signup_company_scrState extends State<Signup_company_scr> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRole();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    colors: [AppColors.primary, AppColors.secondary]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(25))),
            child: Center(
              child: Container(
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTemtextField(
                      controllerfield: namecontroller,
                      hinttext: "Name",
                      itemcount: 50,
                      imagedataa: "assets/images/CONTACT PERSON.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfieldonlyemail(
                      controllerfield: emailcontroller,
                      hinttext: "Email",
                      itemcount: 50,
                      imagedataa: "assets/images/EMAIL MOBILE NUMBER.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  Textfieldonlyphone(
                      controllerfield: mobilecontroller,
                      hinttext: "Mobile No",
                      imagedataa: "assets/images/EMAIL MOBILE NUMBER.png"),

                  // CustomTemtextField(
                  //     controllerfield: contactpersoncontroller,
                  //     hinttext: "Contact Person",
                  //     itemcount: 50,
                  //     imagedataa: "assets/images/CONTACT PERSON.png"),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(

                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.notificationCard,
                    ),
                    child: Center(
                      child:



                      DropdownButtonHideUnderline(
                        child: DropdownButton2<RoleData>(

                          hint:

                          Row(
                            children: [
                              Image.asset(
                                "assets/images/SELECT PROFESSION.png",
                                scale: 1.5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Select Type',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.fieldTextColors,
                                ),
                              ),
                            ],
                          ),
                          value: animalCat,
                          isExpanded: true,

                          onChanged: (RoleData? value) {
                            if(value?.id==6||value?.id==3||value?.id==4||value?.id==5){
                            setState(() {


                              animalCat = value!;
                              catId =  animalCat!.id.toString();
                              print("1111111111111111111111111111${catId}");
                            });
                            }
                          },

                          items: getRolModel?.data?.map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),

                                    child: Container(

                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 0),
                                          child: Text(items.name.toString(),)
                                        )),
                                  ),

                                ],
                              ),
                            );
                          })
                              .toList(),
                        ),

                      ),



                    ),
                  ),

                  catId=='6'?SizedBox():
                  Column(children: [

SizedBox(height: 10,),




                    Container(

                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.notificationCard,
                      ),
                      child: Center(
                        child:


                        DropdownButtonHideUnderline(
                          child:

                          DropdownButton2(
isExpanded: true,
                            //isExpanded: true,

                            hint:

                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/SELECT PROFESSION.png",
                                  scale: 1.5,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Designation',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.fieldTextColors,
                                  ),
                                ),
                              ],
                            ),
                            value: selectedLocation,
                            onChanged: (newValue) {
                              setState(() {
                                selectedLocation = newValue.toString();
                                if (selectedLocation ==
                                    'Owner') {
                                  setState(() {
                                    Designationcontroller.text =
                                    'owner';
                                    print(
                                        Designationcontroller.text);
                                  });
                                }
                                else if(selectedLocation ==
                                    'Purchase Manager'){
                                  setState(() {
                                    Designationcontroller.text =
                                    'purchase_manager';
                                    print(
                                        Designationcontroller.text);
                                  });
                                }
                                else if(selectedLocation ==
                                    'Accountant'){
                                  setState(() {
                                    Designationcontroller.text =
                                    'accountant';
                                    print(
                                        Designationcontroller.text);
                                  });
                                }

                                else if(selectedLocation ==
                                    'Chief Mechanic'){
                                  setState(() {
                                    Designationcontroller.text =
                                    'chief_mechanic';
                                    print(
                                        Designationcontroller.text);
                                  });
                                }
                                else {
                                  setState(() {
                                    Designationcontroller.text =
                                    'other';
                                    print(
                                        Designationcontroller.text);
                                  });
                                }
                              });
                            },
                            items: technician_typeList.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),


                        ),

                      ),
                    ),





                  ],),

SizedBox(height: 10,),
                  Textfieldpassword(
                        controllerfield: pawordcontroller,
                        hinttext: "Password",
                        itemcount: 20,
                        imagedataa: "assets/images/PASSWORD.png"

                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompanyDetailsScre(
                                  name: namecontroller.text,
                                  email: emailcontroller.text,
                                  mobile: mobilecontroller.text,
                                  role: catId.toString(),
                                  designation: Designationcontroller.text,
                                  password: pawordcontroller.text,
                                ),
                              ));
                        }
                      },
                      child: CustomButton(textt: "Next")),

                  SizedBox(height: MediaQuery.of(context).size.height/7,),
                  InkWell(
                      onTap: () {

                       Navigator.pop(context);


                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Already have an account? ",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.blackTemp,fontSize: 17),),
                          Text("Log In",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.secondary,fontSize: 17),),

                        ],
                      )),

                  const SizedBox(
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
  TextEditingController Designationcontroller = TextEditingController();
  TextEditingController SelectProfessioncontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController pawordcontroller = TextEditingController();
  String? selectedLocation ;
  List<String> technician_typeList = ['Owner', 'Purchase Manager', 'Accountant','Chief Mechanic','Other'];


  String? catId;
dynamic animalCat;
  GetRoleModel? getRolModel;
  void getRole() {
    apiBaseHelper.getAPICall(getRoleurl).then((getData) {
      print("get datat ${getData}");
      bool error = getData['status'];
      String msg = getData['message'];

      if (error==true) {

        setState(() {


        getRolModel = GetRoleModel.fromJson(getData);

        });
      } else {


      }
    });
  }


}
