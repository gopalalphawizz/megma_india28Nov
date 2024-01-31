import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:megma_india/Helper/Colors.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Widget/custom_app_button.dart';
import '../../Widget/customfunctionfor_Tostmasg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM")));

    // Check if the user picked a place
    if (result != null) {
      setState(() {
        addressC.text = '${result.formattedAddress}';
        print(addressC.text);
      });
      setState(() {
        lat = "${result.latLng!.latitude}";
        print(lat);

        lang = "${result.latLng!.longitude}";
        print(lang);
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

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Stack(
          children: [
            imageFile == null
                ? ClipPath(
                    clipper: DiagonalPathClipperOne(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.33,
                      color: Colors.red,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Image.asset(
                            "assets/images/227-2271457_dummy-image-jpg.png",
                            fit: BoxFit.fill,
                          )),
                    ),
                  )
                : ClipPath(
                    clipper: DiagonalPathClipperOne(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.33,
                      color: Colors.red,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
            ClipPath(
              clipper: DiagonalPathClipperOne(),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.5),

                      // gradient: LinearGradient(
                      //                        begin: Alignment.centerLeft,
                      //                        end: Alignment.centerRight,
                      //                        colors: [
                      //                      AppColors.secondary,
                      //                    ])
                      //
                    ),
                  )),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 7,
              right: MediaQuery.of(context).size.width / 3,
              left: MediaQuery.of(context).size.width / 3,
              child: imageFile == null
                  ? Stack(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 5, color: AppColors.whiteTemp),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("${imagefiledummy}")),

                            /*backgroundImage: _image != null
                                      ? FileImage(_image!)
                                  as ImageProvider<Object>
                                      : AssetImage(
                                      'assets/images/Profile.png')
                                  as ImageProvider<
                                      Object>,*/ // Explicit casting
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showOptions(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.secondary,
                                ),
                              ),
                            )),
                      ],
                    )
                  : Stack(children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 5, color: AppColors.whiteTemp),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageFile!))),

                        /*backgroundImage: _image != null
                                      ? FileImage(_image!)
                                  as ImageProvider<Object>
                                      : AssetImage(
                                      'assets/images/Profile.png')
                                  as ImageProvider<
                                      Object>,*/ // Explicit casting
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              showOptions(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.secondary,
                              ),
                            ),
                          )),
                    ]),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Center(
            child: Text(
          "${name ?? ''}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 5,
        ),
        isEditProfile
            ? const SizedBox.shrink()
            : Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.account_balance_wallet_sharp,
                    color: AppColors.wallletcolor),
                SizedBox(
                  width: 2,
                ),
                Text(
                  " \u{20B9}${wallet ?? ''}",
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.wallletcolor),
                ),
              ])),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: isEditProfile
              ? Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(children: [
                            Icon(
                              Icons.phone,
                              color: AppColors.secondary,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ]),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              controller: phoneC,
                              decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(top: 0, left: 10),
                                  counterText: ""),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Phone Number';
                                } else if (value.length < 10) {
                                  return 'Please Enter Valid Phone Number';
                                }
                                return null; // Return null if the input is valid
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(children: [
                            Icon(
                              Icons.email,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Email Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ]),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 3,
                            child: TextFormField(
                              maxLength: 10,
                              controller: emailC,
                              // obscureText: isSecure ?? false,
                              decoration: InputDecoration(
                                  hintText: 'Email Address',
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(top: 0, left: 10),
                                  counterText: ""),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Email';
                                } else if (!value.contains('@') ||
                                    !value.contains("gmail.com")) {
                                  return 'Please Enter valid Email';
                                }
                                // else if (value.length<10) {
                                //   return 'Please enter valid Phone Number';
                                // }
                                return null; // Return null if the input is valid
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          textviewRow('Address', Icons.location_on),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 3,
                            child: TextFormField(
                              onTap: () {
                                showPlacePicker();
                              },
                              readOnly: true,
                              controller: addressC,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(top: 0, left: 10),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Address';
                                }
                                return null; // Return null if the input is valid
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              update();
                            }
                          },
                          child: CustomButton(textt: "Update profile"))
                    ],
                  ),
                )
              : Column(
                  children: [
                    textContainer(Icons.email, 'Email Address', emailC.text),
                    const SizedBox(
                      height: 20,
                    ),
                    textContainer(
                        Icons.phone, 'Phone Number', '+91${phoneC.text}'),
                    const SizedBox(
                      height: 20,
                    ),
                    textContainer(Icons.location_on, 'Address', addressC.text),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            isEditProfile = true;
                          });
                        },
                        child: CustomButton(textt: "Edit profile"))
                  ],
                ),
        )
      ]),
    ));
  }

  final _formKey = GlobalKey<FormState>();

  bool isEditProfile = false;
  final phoneC = TextEditingController();
  final emailC = TextEditingController();
  final addressC = TextEditingController();

  Widget textFieldContainer(IconData icon, String title,
      TextEditingController textEditingController) {
    return Column(
      children: [
        textviewRow(title, icon),
        otherTextField(controller: textEditingController),
      ],
    );
  }

  Widget textviewRow(String title, IconData icon) {
    return Row(children: [
      Icon(
        icon,
        color: AppColors.secondary,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      )
    ]);
  }

  Widget otherTextField(
      {TextEditingController? controller, String? hint, bool? isSecure}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: TextFormField(
        controller: controller,
        obscureText: isSecure ?? false,
        decoration: InputDecoration(
          hintText: hint ?? '',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 0, left: 10),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Address';
          }
          return null; // Return null if the input is valid
        },
      ),
    );
  }

  Widget textContainer(IconData icon, String title, String data) {
    return Container(
      height: 90,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.whiteTemp,
          border: Border.all(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 0), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            )
          ]),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.secondary,
            size: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.6,
                child: Text(data,
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> update() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String useridd = prefs.getString('userId').toString();

    var parameter = {
      'user_id': useridd.toString(),
      'email': emailC.text.toString(),
      'mobile': phoneC.text.toString(),
      'address': addressC.text.toString(),
      'lat': lat.toString(),
      'lang': lang.toString(),
    };
    apiBaseHelper.postAPICall(updateprofileUrl, parameter).then(
      (getData) {
        if (getData['status']) {
          customSnackbar(context, getData['message'].toString());
          setState(() {
            isEditProfile = false;
          });

          getProfile();
        } else {
          setState(() {
            isEditProfile = false;
          });
        }
      },
    );
  }

  var wallet;
  var name;
  String? imagefiledummy;

  //
  Future showOptions(
    BuildContext context,
  ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  File? imageFile;

  Future getImageFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = File(image!.path);
    });
    print(imageFile);
    setState(() {});
// Navigator.pop(context) ;
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      imageFile = File(image!.path);
    });
    print(imageFile);

    // Navigator.pop(context) ;
  }

  Future<void> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String useridd = prefs.getString('userId').toString();

    var param = {
      'user_id': useridd.toString(),
    };

    apiBaseHelper.postAPICall(getprofileUrl, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        print('3');

        print('${getData['data']['address']}');
        name = getData['data']['first_name'];
        phoneC.text = getData['data']['mobile'].toString();
        emailC.text = getData['data']['email'].toString();
        addressC.text = getData['data']['address'] ?? '';
        wallet = getData['data']['balance'].toString();
        imagefiledummy = getData['data']['user_image'].toString();
        setState(() {});
        print('4');
      } else {}
    });
  }
}

class DiagonalPathClipperOne extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height / 1.7)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
