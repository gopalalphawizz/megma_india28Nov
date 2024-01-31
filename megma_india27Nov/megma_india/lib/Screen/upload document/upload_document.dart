import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:megma_india/Api%20services/api_services/apiBasehelper.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../../Helper/Colors.dart';
import '../../../Widget/customAppbar.dart';
import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
import '../../Widget/customfunctionfor_Tostmasg.dart';
class UploadDocument extends StatefulWidget {
  const   UploadDocument({super.key,});


  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {


  bool isLoading = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    _controller = VideoPlayerController.asset('assets/Butterfly-209.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet:     Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {

              if(_formKey.currentState!.validate()){


              }

            },

            child:
            Container(
              height: 60,

              decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / (1.5) / 2)),
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.whiteTemp),
                ),
              ),
            ),
            ),
        ),
        appBar:
        PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: CustomAppbar(
              textt: "Upload Document",
            )),
        body:

        Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [



                SizedBox(height: 10,),
                Row(children: [Text("Your Current Address",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                readOnlyFields2(
                  ontab: () {
                    showPlacePicker();

                  },
                  hinttext: 'Current Address',
                  iconData: Icons.location_on,
controllerfield: addresscontroller,
                ),


                SizedBox(height: 10,),
                Row(children: [Text("Installation Date",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                readOnlyFields2(
                  ontab: () {

                    sselectDate(context);
                  },
                  hinttext: 'Installation Date',
                  iconData: Icons.calendar_month,
controllerfield: instalationdatecontroller,
                ),
                SizedBox(height: 10,),
                Row(children: [Text("Car Owner Name",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                CustomTextFieldwithoutIma(
                  itemcount: 30,
                  controllerfield: carownernamecontroller,
                  hinttext: 'Car Owner Name',


                ),
                SizedBox(height: 10,),
                Row(children: [Text("Car Owner Whatsapp Number",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                Textfieldonlyphone(
                  itemcount: 30,
                  controllerfield: whatsappcontroller,
                  hinttext: 'Car Owner Whatsapp Number',
                    imagedataa: "assets/images/EMAIL MOBILE NUMBER.png"

                ),

                SizedBox(height: 10,),
                Row(children: [Text("Car Model",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                CustomTextFieldwithoutIma(
                  itemcount: 30,
                  controllerfield: carModelcontroller,
                  hinttext: 'Car Model',


                ),


                SizedBox(height: 10,),
                Row(children: [Text("Car Model Year",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                CustomTemtextFieldwithoutImage(
                  itemcount: 4,
                  controllerfield: carModelyearcontroller,
                  hinttext: 'Car Model Year',


                ),

                SizedBox(height: 10,),
                Row(children: [Text("Registration Number",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                CustomTextFieldwithoutIma(
                  itemcount: 30,
                  controllerfield: registrationcontroller,
                  hinttext: 'Registration Number',


                ),

                SizedBox(height: 10,),
                Row(children: [Text("Mileage",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                CustomTemtextFieldwithoutImage(
                  itemcount: 4,
                  controllerfield: milagecontroller,
                  hinttext: 'Mileage',


                ),


                SizedBox(height: 10,),
                Row(children: [Text("Chasis Number",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                CustomTextFieldwithoutIma(
                  itemcount: 30,
                  controllerfield: chechiusNumbercontroller,
                  hinttext: 'Chasis Number',


                ),

                SizedBox(height: 10,),
                Row(children: [Text("Type",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
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
                           Icon(Icons.ac_unit,color: AppColors.secondary,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Type',
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


                SizedBox(height: 10,),
                Row(children: [Text("Odometer Reading",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),
                CustomTemtextFieldwithoutImage(
                  itemcount: 4,
                  controllerfield: odometerReadingcontroller,
                  hinttext: 'Odometer Reading',


                ),


                SizedBox(height: 10,),
                Row(children: [Text("Odometer Image",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),

                odometerFile==null?
                readOnlyFields2(
                  ontab: () {

                    showOptions(context,"km");
                  },
                  hinttext: 'Upload',
                  iconData: Icons.file_upload_outlined,

                ):

                InkWell(
                  onTap: () {

                    showOptions(context,"km");


                  },
                  child: Container(height: 80,

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),

                      border: Border.all(color: AppColors.secondary),


                      image:DecorationImage(image: FileImage(File('${odometerFile!.path}'),),fit: BoxFit.fill),
                    ),

                  ),
                ),

                SizedBox(height: 10,),

                Row(children: [Text("Vehicle Photos",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),


                readOnlyFields2(
                  ontab: () {

                  pickImageFile();
                  },
                  hinttext: 'Upload',
                  iconData: Icons.file_upload_outlined,

                ),


                imageList.isNotEmpty
                    ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: imageList.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(

                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),

                            border: Border.all(color: AppColors.secondary),

                          ),

                            child: Image.file(
                                e,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  imageList.remove(e);
                                });
                              },
                              child: Container(

                                color: Colors.white,
                                padding: const EdgeInsets.all(5.0),
                                child: const Icon(
                                  Icons.close,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
                    : const SizedBox.shrink(),

                SizedBox(height: 10,),

                Row(children: [Text("Vehicle Video",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                SizedBox(height: 4,),

                // vehicleFile==null?
                readOnlyFields2(
                  ontab: () {
                    pickVideo();
                  },
                  hinttext: 'Upload',
                  iconData: Icons.file_upload_outlined,

                ),
                    // :

SizedBox(height: 10,),


                _controller.value.isInitialized
                    ?
                Stack(
                      children: [
                        InkWell(
                          onTap: () {


                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                          child:


                          AspectRatio(


                  aspectRatio: _controller.value.aspectRatio,

                  child: VideoPlayer(_controller),
                ),
                        ),

                        Positioned(
                          top: 20,
                          left: 20,
                          child: FloatingActionButton(
                            onPressed: () {
                              // Play or pause the video when the button is pressed
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                              });
                            },
                            child: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),

                      ],
                    )

                    :
                SizedBox.shrink(),

SizedBox(height: 50,),
              ],),
            ),
          ),
        )
      ),
    );
  }
  Future showOptions(
      BuildContext context,String type
      ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Pic Image From Gallery',style: TextStyle(color: AppColors.secondary),),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery(type);
            },
          ),

          CupertinoActionSheetAction(
            child: const Text('Camera',style: TextStyle(color: AppColors.secondary)),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera(type);
            },
          ),
        ],
      ),
    );
  }

  File? vehicleFile;
  File? odometerFile;

  Future getImageFromGallery(String imageFilree) async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
if(imageFilree=="vehicle") {
  vehicleFile = File(image!.path);
}else {
  odometerFile = File(image!.path);


}
    });

    setState(() {});
// Navigator.pop(context) ;
  }

  Future getImageFromCamera(String imageFilree) async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if(imageFilree=="vehicle") {
        vehicleFile = File(image!.path);
      }else {
        odometerFile = File(image!.path);


      }
    });

    // Navigator.pop(context) ;
  }

TextEditingController addresscontroller =TextEditingController();
TextEditingController instalationdatecontroller =TextEditingController();
TextEditingController carownernamecontroller =TextEditingController();
TextEditingController whatsappcontroller =TextEditingController();
TextEditingController carModelcontroller =TextEditingController();
TextEditingController carModelyearcontroller =TextEditingController();
TextEditingController registrationcontroller =TextEditingController();
TextEditingController milagecontroller =TextEditingController();
TextEditingController selecttypecontroller =TextEditingController();
TextEditingController odometerReadingcontroller =TextEditingController();
TextEditingController chechiusNumbercontroller =TextEditingController();


  List <Map<String, dynamic>> checKImageFile=[];
Future<void> upload() async {
  setState(() {
    isLoading=true;
  });
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var  userId =prefs.getString('userId');

  var param={
"dd":"sss"
  };

  if(vehicleFile!=null){

    List<Map<String, dynamic>> imagefile=[

      {
        "key": "user_image",
        "filePath":"${vehicleFile!.path}"

      },

    ];

    checKImageFile.addAll(imagefile);
    setState(() {

    });
  }else if(odometerFile!=null
  ){

    List<Map<String, dynamic>> imagefile=[

      {
        "key": "aadhar_card_f",
        "filePath":"${odometerFile!.path}"

      },

    ];

    checKImageFile.addAll(imagefile);
    setState(() {

    });

  }

  apiBaseHelper.postMultipartAPICall(uploadtemUrl, param,checKImageFile).then((getData){

    bool error=getData['status'];
    String?msg=getData['message'];
    if(error==true){


      customSnackbar(context, msg.toString());

      setState(() {
        isLoading = false;
      });


    }else{

    }


  }
  );
}

  String? selectedLocation ;
  List<String> technician_typeList = ['Front','Back'];


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
        addresscontroller.text='${result.formattedAddress}';
        print(addresscontroller.text);
      });
      setState(() {
        lat="${result.latLng!.latitude}";
        print(lat);

        lang="${result.latLng!.longitude}";
        print(lang);

      });
    }
  }

  var lat;
  var lang;
  DateTime selectedDate = DateTime.now();
  Future<void> sselectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)

      selectedDate = picked;


    instalationdatecontroller.text =
          DateFormat('yyyy-MM-dd').format(selectedDate);
      print("==================${instalationdatecontroller.text}");
      setState(() {

      });

  }
  final _formKey = GlobalKey<FormState>();
  void pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      String filePath = result.files.single.path!;
      _initializeVideoPlayer(filePath);
    } else {
      // User canceled the file picker
    }
  }
  late VideoPlayerController _controller;

  void _initializeVideoPlayer(String videoPath) {
    _controller = VideoPlayerController.file(File(videoPath))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }
  List<File> imageList = [];
  pickImageFile() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        File file = File(image.path);
        imageList.add(file);
      });
    } else {
      // Fluttertoast.showToast(msg: "Please Pick Again");
    }
  }



}