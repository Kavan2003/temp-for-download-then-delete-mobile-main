import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenovo_app/screens/all_leads_page.dart';
import 'package:lenovo_app/screens/new_leads_page.dart';
import 'package:lenovo_app/screens/follow_up_page.dart';
import 'package:lenovo_app/screens/accepted_leads_page.dart';
import 'package:lenovo_app/screens/reject_leads_page.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

bool gotoallindex = false;

class Manage extends StatelessWidget {
  const Manage({Key? key, required int initialTabIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: 2,
          length: 5, // Set the length to 5 for 5 tabs
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  ButtonsTabBar(
                    onTap: (value) {
                      print("index $value");
                    },
                    height: Get.height * 0.05,
                    radius: 30,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: const Color(0XFF294E95),
                    unselectedBackgroundColor: const Color(0XFFEAEEF5),
                    unselectedLabelStyle:
                        const TextStyle(color: Color(0XFF294E95)),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    buttonMargin: const EdgeInsets.symmetric(horizontal: 10),
                    tabs: const [
                      Tab(
                        text: "ALL",
                      ),
                      Tab(
                        text: "NEW",
                      ),
                      Tab(
                        text: "FOLLOW UP",
                      ),
                      Tab(
                        text: "ACCEPTED",
                      ),
                      Tab(
                        text: "REJECT",
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SafeArea(
                      child: TabBarView(
                        children: <Widget>[
                          // Use the corresponding widget for each tab's content
                          AllLeadsPage(
                            data: {},
                          ),
                          NewLeadsPage(
                            data: {},
                          ),
                          FollowUpPage(
                            data: {},
                          ),
                          AcceptedLeadsPage(
                            data: {},
                          ),
                          RejectLeadsPage(
                            data: {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
