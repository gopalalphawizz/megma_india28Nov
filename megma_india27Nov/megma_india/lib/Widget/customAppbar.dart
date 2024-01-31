import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/Colors.dart';

class CustomAppbar extends StatefulWidget {
  String ?textt;

CustomAppbar({Key? key,this.textt,}) : super(key: key);
 
  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {


  @override
  Widget build(BuildContext context) {
    return
      Container(height: 80,

        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(


            gradient:RadialGradient(colors:

            [AppColors.primary,AppColors.secondary]

            ) ,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
        child: Center(child:

        Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            InkWell(
              onTap: () {

               Navigator.pop(context);

              },
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Icon(Icons.arrow_back_ios,color: AppColors.whiteTemp,),
                ],
              ),
            ),
            Text('${widget.textt.toString()}',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whiteTemp,fontSize: 20),),

            // widget.ontab!=null?
            //     InkWell(
            //
            //         onTap:() => widget.ontab,
            //         child: Icon(Icons.notifications_none_rounded,color: AppColors.whiteTemp,)):
            //
            SizedBox(width: 30,),
          ],
        ),

        ),
      );

  }
}



