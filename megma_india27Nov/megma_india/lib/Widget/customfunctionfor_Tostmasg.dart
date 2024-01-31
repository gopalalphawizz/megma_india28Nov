import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:megma_india/Helper/Colors.dart';

void customSnackbar(BuildContext context,String msg){
print('tyuiolkoiug');

  ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
    content: Container(
       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.secondary, // Change the background color
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: Colors.white), // Change icon color
          SizedBox(width: 8.0),
          SizedBox(
            width: MediaQuery.of(context).size.width/1.5,
            child: Text(
              msg,
              maxLines: 4,
              style: TextStyle(color: Colors.white), // Change text color
            ),
          ),
        ],
      ),
    ),
  ));

}