import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenovo_app/constants/colorConstants.dart';
import 'package:lenovo_app/screens/home.dart';
import 'package:lenovo_app/screens/manager_page.dart';
import 'package:lenovo_app/screens/profile.dart';
import 'package:lenovo_app/screens/searchScreen.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

import '../constants/imageConstants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final String profileImageUrl;
  bool ismanager = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    profileImageUrl = AppPersist.getString(AppStrings.userimage, "");
    var a = AppPersist.getString(AppStrings.role, '');

    if (a == '') {
      throw Exception("Role not found");
    } else if (a == 'SALE MANAGER') {
      ismanager = true;
      log(
        "Role is Manager",
      );
    } else {
      ismanager = false;
      log("Role is not Manager");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int selectedindex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      selectedindex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              width: 80,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Get.to(SearchScreen());
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          ),
          //

          GestureDetector(
            onTap: () {
              Get.to(ProfilePage());
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: profileImageUrl == ""
                    ? Image.asset(
                        ImageConstants.userImage,
                        height: Get.height * 0.07,
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(profileImageUrl),
                      )),
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            backgroundColor: ColorConstants.lightGreyColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedindex,
            selectedItemColor: Colors.green, // Color for selected icons
            unselectedItemColor: Colors.red, // Color for unselected icons
            onTap: onTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: selectedindex == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'assets/icons/selected_menuhom.png',
                          height: Get.height * 0.05,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'assets/icons/menuhom.png',
                          height: Get.height * 0.05,
                        ),
                      ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: selectedindex == 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'assets/icons/selected_menulead.png',
                          height: Get.height * 0.05,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'assets/icons/menulead.png',
                          height: Get.height * 0.05,
                        ),
                      ),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [const Home(), Manage(initialTabIndex: 2)],
      ),
    );
  }
}
