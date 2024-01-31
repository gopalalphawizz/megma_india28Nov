import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:megma_india/Api%20services/api_services/apiBasehelper.dart';
import 'package:megma_india/Api%20services/api_services/apiStrings.dart';
import 'package:megma_india/Screen/Auth/brandScreen.dart';
import 'package:megma_india/Screen/Auth/login_scr.dart';
import 'package:megma_india/Screen/my_orders/my_orders.dart';
import 'package:megma_india/Widget/extention.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/Colors.dart';

import '../Catogery Screen/CatogryScreen.dart';
import '../Faq/faqScreen.dart';
import '../Home Screen/homeScreen.dart';
import '../My_enquiery/my_enquiery.dart';
import '../Notification Screen/notificationScreen.dart';
import '../Privecy Policy/privecyPolicy.dart';
import '../Receieve Enquiry/receieve_enquiery.dart';
import '../ScannerScreen/scannerScreen.dart';
import '../Term Condition/termAndCondation.dart';
import '../complet register/complantRegisterList.dart';
import '../complet register/complete_register.dart';
import '../custumer Support/custumerSupport.dart';
import '../upload document/uploadedList.dart';
import '../user Profile/userProfile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    getuserid();

  }


  Future<void> getuserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     userid = prefs.getString('userId').toString();
     role = prefs.getString('role').toString();
    getProfile();
  }



  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Category_Screen(),
    ProfileScreen(),
  ];

  static const List<Widget> _widgetOptions1 = <Widget>[
    HomeScreen(),
    Scanne_Screen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Exit"),
                  content: const Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary),
                      child: const Text("YES"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary),
                      child: const Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return true;
        },
        child: Scaffold(
          key: openDrawer,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(_selectedIndex == 2 ? 0 : 80),
              child: _selectedIndex == 2 || _selectedIndex == 1
                  ? const SizedBox()
                  : Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                              colors: [AppColors.primary, AppColors.secondary]),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                openDrawer.currentState!.openDrawer();
                              },
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  _selectedIndex == 0
                                      ? Image.asset(
                                          'assets/images/Group 74898.png',
                                          scale: 1.5,
                                        )
                                      : _selectedIndex == 1
                                          ? const SizedBox()
                                          : const SizedBox()
                                ],
                              ),
                            ),
                            _selectedIndex == 0
                                ? const Text(
                                    'Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteTemp,
                                        fontSize: 20),
                                  )
                                : const SizedBox(
                                    width: 10,
                                  ),
                            Row(
                              children: [
                                _selectedIndex == 0
                                    ? Image.asset(
                                        'assets/images/Icon feather-bell.png',
                                        scale: 1.5,
                                      )
                                    : _selectedIndex == 1
                                        ? Image.asset(
                                            'assets/images/Icon feather-bell.png',
                                            scale: 1.5,
                                          )
                                        : const SizedBox(
                                            width: 30,
                                          ),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
          drawer: Drawer(
            child: ListView(children: [
               DrawerHeader(
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                        colors: [AppColors.primary, AppColors.secondary])),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 43,
                      backgroundColor: AppColors.whiteTemp,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          profile ?? '',
                        ),
                        radius: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hello!',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          name?.capitalize() ?? '',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
                    );
                  },
                  child: DrawerIconTab(
                    titlee: 'Home',
                    icon: Icons.home,
                    tabb: 1,
                    indexx: currentIndex,
                  )),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const notificationPage()),
                    );
                  },
                  child: DrawerIconTab(
                      titlee: 'Notification',
                      icon: Icons.notification_add,
                      tabb: 2,
                      indexx: currentIndex)),


              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const notificationPage()),
                    // );
                  },
                  child: DrawerIconTab(
                      titlee: 'Wallet',
                      icon: Icons.notification_add,
                      tabb: 3,
                      indexx: currentIndex)),

              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 4;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BrandScreen()),
                    );
                  },
                  child: DrawerIconTab(
                      titlee: 'Brand',
                      icon: Icons.notification_add,
                      tabb: 4,
                      indexx: currentIndex)),



              const SizedBox(
                height: 5,
              ),




              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 5;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyOrdersScreen()),
                    );
                  },
                  child: DrawerIconTab(
                      titlee: 'My Orders',
                      icon: Icons.notification_add,
                      tabb: 5,
                      indexx: currentIndex)),


              const SizedBox(
                height: 5,
              ),

              role=="4"||role=="5"||role=="3"?
              Column(children: [

                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 6;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReceivedOrders()),
                      );
                    },
                    child: DrawerIconTab(
                        titlee: 'Received Orders',
                        icon: Icons.notification_add,
                        tabb: 6,
                        indexx: currentIndex)),
              ],):SizedBox.shrink(),

              role=="4"||role=="5"||role=="6"?
              Column(children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 7;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadedListScr()),
                      );
                    },
                    child: DrawerIconTab(
                        titlee: 'My Installation',
                        icon: Icons.notification_add,
                        tabb: 7,
                        indexx: currentIndex)),


                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 8;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Scanne_Screen()),
                      );
                    },
                    child: DrawerIconTab(
                        titlee: 'Product Fitment',
                        icon: Icons.notification_add,
                        tabb: 8,
                        indexx: currentIndex)),


                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 9;
                      });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const Complent_Register()),
                      // );
                    },
                    child: DrawerIconTab(
                        titlee: 'Warranty Claim',
                        icon: Icons.notification_add,
                        tabb: 9,
                        indexx: currentIndex)),
                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 10;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Complent_Register()),
                      );
                    },
                    child: DrawerIconTab(
                        titlee: 'Complaint Register',
                        icon: Icons.notification_add,
                        tabb: 10,
                        indexx: currentIndex)),
                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 11;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ComplantListScre()),
                      );
                    },
                    child: DrawerIconTab(
                        titlee: 'Complaint Register List',
                        icon: Icons.notification_add,
                        tabb: 11,
                        indexx: currentIndex)),
              ],):SizedBox.shrink(),


              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 12;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const custmerSupport()),
                    );
                  },
                  child: DrawerIconTab(
                      titlee: 'Customer Support',
                      icon: Icons.file_copy,
                      tabb: 12,
                      indexx: currentIndex)),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 13;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const privacy_policy()),
                    );
                  },
                  child: DrawerIconTab(
                    titlee: 'Privacy Policy',
                    icon: Icons.file_copy,
                    tabb: 13,
                    indexx: currentIndex,
                  )),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 14;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const termsAndCondition()),
                    );
                  },
                  child: DrawerIconTab(
                    titlee: 'Terms & Conditions',
                    icon: Icons.file_copy,
                    tabb: 14,
                    indexx: currentIndex,
                  )),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 15;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FaqPage()),
                    );
                  },
                  child: DrawerIconTab(
                    titlee: 'FAQ',
                    icon: Icons.payment,
                    tabb: 15,
                    indexx: currentIndex,
                  )),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = 16;
                    });
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Logout"),
                            content: const Text("Are you sure to Logout?"),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColors.secondary),
                                child: const Text("YES"),
                                onPressed: () async {
                                  setState(() {
                                    removesession();
                                  });
                                  Navigator.pop(context);
                                  // SystemNavigator.pop();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login_Screen(),
                                      ));
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColors.secondary),
                                child: const Text("NO"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: DrawerIconTab(
                    titlee: 'Logout',
                    icon: Icons.logout_outlined,
                    tabb: 7,
                    indexx: currentIndex,
                  )),
              const SizedBox(
                height: 5,
              ),
            ]),
          ),
          body: Center(
            child:

            role=="6"? _widgetOptions1.elementAt(_selectedIndex):
            _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedIndex == 0
                              ? Colors.orange
                              : Colors.white),
                      child: Icon(
                        Icons.home,
                        size: 15,
                        color:
                            _selectedIndex == 0 ? Colors.white : Colors.black,
                      )),
                ),
                label: 'Home',
              ),


              BottomNavigationBarItem(
                icon: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedIndex == 1
                              ? Colors.orange
                              : Colors.white),
                      child:

                      role=="4"||role=="5"||role=="6"?
                      Icon(
                        Icons.document_scanner_sharp,
                        size: 15,
                        color:
                            _selectedIndex == 1 ? Colors.white : Colors.black,
                      ):
                      Icon(
                        Icons.line_style_outlined,
                        size: 15,
                        color:
                        _selectedIndex == 1 ? Colors.white : Colors.black,
                      )


                  ),


                ),
                label:
                role=="4"||role=="5"||role=="6"?
                    "Scanner":

                'Categories',
              ),
              BottomNavigationBarItem(
                icon: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedIndex == 2
                              ? Colors.orange
                              : Colors.white),
                      child: Icon(
                        Icons.person_2_outlined,
                        size: 15,
                        color:
                            _selectedIndex == 2 ? Colors.white : Colors.black,
                      )),
                ),
                label: 'My Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> openDrawer = GlobalKey();
  int _selectedIndex = 0;
  int currentIndex = 99;

  String? name;
  String? email;
  String? profile;
  String? userid ;
  String? role ;

  removesession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('role');
  }


  Future<void> getProfile() async {


    var param = {
      'user_id': userid,
    };

    apiBaseHelper.postAPICall(getprofileUrl, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        name = getData['data']['first_name'];
        email = getData['data']['email'].toString();
        profile = getData['data']['user_image'].toString();
        setState(() {});
      } else {}
    });
  }
}

class DrawerIconTab extends StatefulWidget {
  final IconData? icon;
  final String? titlee;
  final int? tabb;
  final int? indexx;

  DrawerIconTab({Key? key, this.icon, this.titlee, this.tabb, this.indexx})
      : super(key: key);

  @override
  State<DrawerIconTab> createState() => _DrawerIconTabState();
}

class _DrawerIconTabState extends State<DrawerIconTab> {
  var Select = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: widget.indexx == widget.tabb ? AppColors.secondary : null),
      child: Row(
        children: [
          const SizedBox(
            width: 13,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: widget.indexx == widget.tabb
                  ? AppColors.whiteTemp
                  : AppColors.secondary,
            ),
            height: 35,
            width: 35,
            child: Center(
                child: Icon(
              widget.icon,
              color: widget.indexx == widget.tabb
                  ? AppColors.secondary
                  : AppColors.whiteTemp,
              size: 20,
            )),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            '${widget.titlee}',
            style: TextStyle(
                fontSize: 15,
                color:
                    widget.indexx == widget.tabb ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
