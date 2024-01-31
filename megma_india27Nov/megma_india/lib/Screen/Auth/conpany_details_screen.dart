import 'package:flutter/material.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:megma_india/Screen/Auth/kyc_details_scr.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
class CompanyDetailsScre extends StatefulWidget {

  String ?name;
  String ?email;
  String ?mobile;
  String ?designation;
  String ?role;
  String ?password;
  CompanyDetailsScre({Key? key,this.name,this.email,this.mobile,this.designation,this.role,this.password}) : super(key: key,);

  @override
  State<CompanyDetailsScre> createState() => _CompanyDetailsScreState();
}

class _CompanyDetailsScreState extends State<CompanyDetailsScre> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: SingleChildScrollView(
        child: Column(children: [
          Container(height: 80,

            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(


                gradient: RadialGradient(colors:

                [AppColors.primary, AppColors.secondary]

                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Center(child:

            Text('Company Details', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteTemp,
                fontSize: 20),),

            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: _formKey,
              child: Column(children: [

                Row(children: [
                  SizedBox(height: 50,),

                  Text('Company Address:', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackTemp,
                      fontSize: 15),),


                ],),


                SizedBox(height: 10,),


                CustomTemtextField(
                    controllerfield: companynamecontroller,
                    hinttext: "Company Name",
                    itemcount: 50,
                    imagedataa: "assets/images/COMPANY NAME.png"),

                SizedBox(height: 10,),

                readOnlyFields(
                    ontab: () {
                      showPlacePicker();
                    },
                    controllerfield: compaanyaddresscontroller,
                    hinttext: "Company Address",
                    itemcount: 50,
                    imagedataa: "assets/images/COMPANY NAME.png"),
                SizedBox(height: 10,),


                readOnlyFields(
                    controllerfield: statecontroller,
                    hinttext: "State",
                    itemcount: 50,
                    imagedataa: "assets/images/COMPANY NAME.png"),

                SizedBox(height: 10,),
                readOnlyFields(
                    controllerfield: pincodecontroller,
                    hinttext: "Pin Code",
                    itemcount: 50,
                    imagedataa: "assets/images/COMPANY NAME.png"),
                SizedBox(height: 10,),
                readOnlyFields(
                    controllerfield: citicontroller,
                    hinttext: "City",
                    itemcount: 50,
                    imagedataa: "assets/images/COMPANY NAME.png"),
                SizedBox(height: 10,),


                CustomTemtextField(
                    controllerfield: areacontroller,
                    hinttext: "Area",
                    itemcount: 50,
                    imagedataa: "assets/images/COMPANY NAME.png"),
                SizedBox(height: 10,),


            TextFormField(

              controller: buildingNocontroller,
               keyboardType: TextInputType.number,
              validator: (msg) {
                if (msg!.isEmpty) {
                  return "Please Enter Building No";
                }
              },
              maxLength: 5,
              decoration: InputDecoration(
                fillColor: AppColors.notificationCard,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.notificationCard)),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.notificationCard,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.notificationCard)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.notificationCard)),
                filled: true,
                border: InputBorder.none,
                counterText: "",
                hintText: "Building No",
                hintStyle: TextStyle(color: AppColors.fieldTextColors),
                prefixIcon: Image.asset(
                  "assets/images/COMPANY NAME.png",
                  scale: 1.5,
                ),
              ),
            ),

                SizedBox(height: 50,),

                InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              KycScreen(name: widget.name.toString(),
                                email: widget.email.toString(),
                                mobile: widget.mobile.toString(),
                                designation: widget.designation.toString(),
                                role: widget.role.toString(),
                                comaddress: compaanyaddresscontroller.text.toString(),
                                comstate: statecontroller.text,
                                comcity: citicontroller.text,
                                comarea: areacontroller.text,
                                combuildingNo: buildingNocontroller.text,
                                companyname: companynamecontroller.text,
                                compincode: pincodecontroller.text,
                                password: widget.password.toString(),
                              lat: lat.toString(),
                                lang: lat.toString(),
                              ),));
                      }
                    },
                    child: CustomButton(textt: "Next")),


                SizedBox(height: 20,),

              ],),
            ),
          ),
        ]),
      ),
    ));
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController companynamecontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController citicontroller = TextEditingController();
  TextEditingController areacontroller = TextEditingController();
  TextEditingController buildingNocontroller = TextEditingController();
  TextEditingController compaanyaddresscontroller = TextEditingController();

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                PlacePicker(


                    "AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM"))

    );


    // Check if the user picked a place
    if (result != null) {
      setState(() {
        compaanyaddresscontroller.text='${result.formattedAddress}';
        print(compaanyaddresscontroller.text);
      });
      setState(() {
        lat="${result.latLng!.latitude}";
        print(lat);

        lang="${result.latLng!.longitude}";
        print(lang);
     citicontroller.text= result.city!.name.toString();
      statecontroller.text = result.administrativeAreaLevel1!.name.toString();
    pincodecontroller.text = result.postalCode.toString();
      // print('City: $city');
      // print('Pincode: $pincode');
      // print('State: $state');
      // print('contry: $country');
      });
    }
  }
  String _getAreaFromAddress(String formattedAddress) {
    List<String> addressComponents = formattedAddress.split(', ');

    String area = addressComponents.firstWhere(
          (element) => element.endsWith('Area'),
      orElse: () => 'N/A',
    );

    return area;
  }
  var lat;
  var lang;
}
