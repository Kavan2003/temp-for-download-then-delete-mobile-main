import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widget/homepage_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 6,
        child: Stack(
          children: [
            Column(children: <Widget>[
              ButtonsTabBar(
                height: Get.height * 0.05,
                radius: 30,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Color(0XFF294E95),
                unselectedBackgroundColor: Color(0XFFEAEEF5),
                unselectedLabelStyle: TextStyle(color: Color(0XFF294E95)),
                labelStyle: TextStyle(
                    fontSize: Get.height * 0.018,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                buttonMargin: EdgeInsets.symmetric(horizontal: 10),
                tabs: const [
                  Tab(
                    text: "TODAY",
                  ),
                  Tab(
                    text: "YESTERDAY",
                  ),
                  Tab(
                    text: "MONTH",
                  ),
                  Tab(
                    text: "QUATER",
                  ),
                  Tab(
                    text: "YTD",
                  ),
                  Tab(
                    text: "LIFETIME",
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: HCard(
                          data: {},
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: HCard(
                          data: {},
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: HCard(
                          data: {},
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: HCard(
                          data: {},
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: HCard(
                          data: {},
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: HCard(
                          data: {},
                        )),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
