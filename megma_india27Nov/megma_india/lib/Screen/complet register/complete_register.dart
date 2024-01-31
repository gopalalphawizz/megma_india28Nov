import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Helper/Colors.dart';
import '../../../Widget/customAppbar.dart';
import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Widget/customTextField.dart';
import '../../Widget/custom_app_button.dart';
class Complent_Register extends StatefulWidget {
  const   Complent_Register({super.key,});


  @override
  State<Complent_Register> createState() => _Complent_RegisterState();
}

class _Complent_RegisterState extends State<Complent_Register> {


  bool isLoading = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar:
          PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: CustomAppbar(
                textt: "Complaint Register",
              )),
          body:

          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(children: [

                  Row(children: [Text("Vehicle Photos",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                  SizedBox(height: 4,),

                  imageFile==null?
                  readOnlyFields2(
                    ontab: () {

                      showOptions(context,"vehicle");
                    },
                    hinttext: 'Upload',
                    iconData: Icons.file_upload_outlined,

                  ):


                  InkWell(
                    onTap: () {

                      showOptions(context,"vehicle");


                    },
                    child: Container(height: 80,

                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),

                        border: Border.all(color: AppColors.secondary),


                        image:DecorationImage(image: FileImage(File('${imageFile!.path}'),),fit: BoxFit.fill),
                      ),

                    ),
                  ),



                  SizedBox(height: 10,),
                  Row(children: [Text("Number Plate",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                  SizedBox(height: 4,),
                  CustomTemtextFieldwithoutImage(
                    itemcount: 30,
                    controllerfield: numberplatecontroller,
                    hinttext: '',


                  ),

                  SizedBox(height: 10,),
                  Row(children: [Text("Chasis Number",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                  SizedBox(height: 4,),
                  CustomTemtextFieldwithoutImage(
                    itemcount: 30,
                    controllerfield: chechiusNumbercontroller,
                    hinttext: '',


                  ),
                  SizedBox(height: 10,),
                  Row(children: [Text("K.M. reading",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blackTemp),)],),

                  SizedBox(height: 4,),

                  kmFile==null?
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


                        image:DecorationImage(image: FileImage(File('${kmFile!.path}'),),fit: BoxFit.fill),
                      ),

                    ),
                  ),
                  SizedBox(height: 60,),


                  InkWell(
                    onTap: () {

if(_formKey.currentState!.validate()){


}

                    },
                    child:

                  CustomButton(textt: "Submit")
                    ,)
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

  File? imageFile;
  File? kmFile;

  Future getImageFromGallery(String imageFilree) async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if(imageFilree=="vehicle") {
        imageFile = File(image!.path);
      }else {
        kmFile = File(image!.path);


      }
    });
    print(imageFile);
    setState(() {});
// Navigator.pop(context) ;
  }

  Future getImageFromCamera(String imageFilree) async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if(imageFilree=="vehicle") {
        imageFile = File(image!.path);
      }else {
        kmFile = File(image!.path);


      }
    });
    print(imageFile);

    // Navigator.pop(context) ;
  }

  TextEditingController numberplatecontroller =TextEditingController();
  TextEditingController chechiusNumbercontroller =TextEditingController();
  Future<void> ClamRegister() async {

    setState(() {
      isLoading=true;
    });
    var param={

      'jjjjj':"jj",

    };
    apiBaseHelper.postAPICall(addclamUrl, param).then((getData){
      bool error=getData['status'];
      String msg=getData['message'];
      if(error==true){



        setState(() {
          isLoading=false;
        });
      }else{

        setState(() {
          isLoading=false;
        });
      }


    });

  }
  final _formKey = GlobalKey<FormState>();

}