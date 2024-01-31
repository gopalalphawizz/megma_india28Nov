import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/Colors.dart';
import '../../Widget/custom_app_button.dart';
import '../upload document/upload_document.dart';

class ScanPay extends StatefulWidget {
  const ScanPay({Key? key}) : super(key: key);

  @override
  State<ScanPay> createState() => _ScanPayState();
}

class _ScanPayState extends State<ScanPay> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    getuserId();

    super.initState();


    _onQRViewCreated;
  }




  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: <Widget>[
          SizedBox(height:MediaQuery.of(context).size.width/2.5,),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width/1.5,
            height: MediaQuery.of(context).size.width/1.5,
            decoration: BoxDecoration(
                color: AppColors.primary,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10)
            ),
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: InkWell(
              onTap: () {

              },
              child: Container(

                height: 45,
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 150,

              ),
            ),
          ),

        ],
      ),
    );
  }

  _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UploadDocument(),));
        print("snann result==========${result!.code}");
        controller.dispose();

      }else{
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  var useriddd;
  Future<void> getuserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    useriddd = prefs.getString('userId');
    print(
        'use id in scan screen-=========================${useriddd
            .runtimeType}');
    print('user id in scan screen-=========================${useriddd}');
  }

}





class Scanne_Screen extends StatefulWidget {
  const Scanne_Screen({super.key});

  @override
  State<Scanne_Screen> createState() => _Scanne_ScreenState();
}

class _Scanne_ScreenState extends State<Scanne_Screen> {
  late Future<dynamic> futureCatData ;


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
            preferredSize: Size.fromHeight(80),
            child:

            Container(height: 80,

              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(


                  gradient:RadialGradient(colors:

                  [AppColors.primary,AppColors.secondary]

                  ) ,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
              child: Center(child:


              Text('Scanner',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whiteTemp,fontSize: 20),),


              ),
            ),
          ),
          body:


          Padding(
              padding:  EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
              child:

    Scanner(context),



          )


      ),
    );
  }

  Widget Scanner(BuildContext context){

    return SingleChildScrollView(
      child: Column(

        children: [
          Row(
            children: [
              Text("QR Code Scan",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
            ],
          ),


          SizedBox(height: MediaQuery.of(context).size.height/8,),

          Image.asset('assets/images/scan.png',height: 200,width: 200,),
          SizedBox(height: MediaQuery.of(context).size.height/10,),




          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(

                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScanPay(),));
                  },
                  child: CustomButton(textt: "Scan")),
            ],
          ),


        ],),
    );
  }


}






