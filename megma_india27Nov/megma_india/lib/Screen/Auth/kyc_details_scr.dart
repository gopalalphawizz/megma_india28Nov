import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:megma_india/Helper/Colors.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
import '../../Widget/customfunctionfor_Tostmasg.dart';
import 'bankdetailsscreen.dart';
import 'login_scr.dart';

class KycScreen extends StatefulWidget {
  String? name;
  String? email;
  String? mobile;
  String? companyname;
  String? designation;
  String? role;
  String? comaddress;
  String? comstate;
  String? comcity;
  String? comarea;
  String? compincode;
  String? combuildingNo;
  String? password;
  String? lat;
  String? lang;
  KycScreen(
      {Key? key,
      this.name,
      this.email,
      this.mobile,
      this.companyname,
      this.designation,
      this.role,
      this.comaddress,
      this.comstate,
      this.comarea,
      this.comcity,
      this.compincode,
      this.combuildingNo,
      this.password,
      this.lang,
      this.lat})
      : super(
          key: key,
        );

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  @override
  void initState() {
    // TODO: implement initState

    print('${widget.role}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [AppColors.primary, AppColors.secondary]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Center(
              child: Text(
                'KYC',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteTemp,
                    fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      widget.role == "3"
                          ? Text(
                              'KYC for Distributors:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackTemp,
                                  fontSize: 15),
                            )
                          : widget.role == "6"
                              ? Text(
                                  'KYC for Mechanic Owners:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackTemp,
                                      fontSize: 15),
                                )
                              : widget.role == "4"
                                  ? Text(
                                      'KYC for Retailers:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackTemp,
                                          fontSize: 15),
                                    )
                                  : widget.role == "5"
                                      ? Text(
                                          'KYC for workshop owners:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.blackTemp,
                                              fontSize: 15),
                                        )
                                      : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                            textfieldAdhat(
                                controllerfield: adharcontroller,
                                hinttext: "Adhar Number",
                                imagedataa: "assets/images/COMPANY NAME.png"),
                            SizedBox(
                              height: 10,
                            ),


                  textfieldPan(
                      controllerfield: pannumberController,
                      hinttext: "Pan Number",
                      imagedataa: "assets/images/COMPANY NAME.png"),
                  SizedBox(
                    height: 10,
                  ),



                            CustomTemtextField(
                                controllerfield: gstnumbercontroller,
                                hinttext: "GST Number",
                                itemcount: 50,
                                imagedataa: "assets/images/COMPANY NAME.png"),
                            SizedBox(
                              height: 10,
                            ),


                       CustomTemtextField(
                          controllerfield: currentphycionaaddress,
                          hinttext: "Residence Address",
                          itemcount: 50,
                          imagedataa: "assets/images/COMPANY NAME.png"),

                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () {
                        // if (_formKey.currentState!.validate()) {
                        //   if (widget.role == "6") {
                            // ragistrationApi();
                          // } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BankdetailsScr(
                                    name: widget.name,
                                    password: widget.password,
                                    email: widget.email,
                                    mobile: widget.mobile,
                                    designation: widget.designation,
                                    role: widget.role,
                                    companyname: widget.companyname,
                                    comaddress: widget.comaddress,
                                    comstate: widget.comstate,
                                    comcity: widget.comcity,
                                    compincode: widget.compincode,
                                    combuildingNo: widget.combuildingNo,
                                    comarea: widget.comarea,
                                    adhar: adharcontroller.text.toString(),
                                    pan: pannumberController.text,
                                    gst: gstnumbercontroller.text.toString(),
                                    currentphysicaladdress:
                                        currentphycionaaddress.text,
                                    lang: widget.lang.toString(),
                                    lat: widget.lat.toString(),
                                  ),
                                ));
                        //   }
                        // }
                      },
                      child: CustomButton(textt: "Next")),
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
  TextEditingController adharcontroller = TextEditingController();
  TextEditingController pannumberController = TextEditingController();
  TextEditingController gstnumbercontroller = TextEditingController();
  TextEditingController currentphycionaaddress = TextEditingController();

  Future<void> ragistrationApi() async {
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
      'pancard': pannumberController.text.toString(),
      'gst': gstnumbercontroller.text.toString(),
      'current_address': currentphycionaaddress.text.toString(),
      'state': widget.comstate,
      'city': widget.comcity,
      'area': widget.comarea,
      'pincode': widget.compincode,
      'building_no': widget.combuildingNo,
      'aadhar': adharcontroller.text.toString(),
    };

    apiBaseHelper.postAPICall(registerUrl, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        setState(() {
          customSnackbar(context, msg.toString());

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login_Screen()),
              (Route<dynamic> route) => false);
        });
      } else {
        setState(() {
          customSnackbar(context, msg.toString());

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login_Screen()),
              (Route<dynamic> route) => false);
        });
      }
    });
  }

  String? _selectvehiclecat;
  List selectvehicle_List = ['Advance', 'Credit'];
}
