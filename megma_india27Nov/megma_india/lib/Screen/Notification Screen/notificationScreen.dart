import 'package:flutter/material.dart';
import 'package:megma_india/Helper/Colors.dart';

import '../../Widget/customAppbar.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({Key? key}) : super(key: key);
  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child:

              CustomAppbar(
                textt: "Notification",

              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 25, right: 25, bottom: 20),
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),

                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                        ),
                      ],

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      // border: Border.all(color: Colors.black.withOpacity(0.3)
                      //
                      // )
                    ),
                    child: const TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.fieldColors,
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                            fontSize: 15, color: AppColors.fieldColors),
                        border: InputBorder.none,
                      ),
                    )),

                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.blackTemp,
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Text(
                      'Clear All',
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.blackTemp,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  height: MediaQuery.of(context).size.height/1.2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(

                          decoration: BoxDecoration(
                              color: AppColors.notificationCard,
                              borderRadius: BorderRadius.circular(15)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      'assets/images/notification.png'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        Text(

                                          'Just Now',


                                          style: TextStyle(
                                              fontSize: 10, color: AppColors.secondary),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Ramu",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(

                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width/1.7,
                                        child: Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )


              ]),
            ),
          )),
    );
  }


}
