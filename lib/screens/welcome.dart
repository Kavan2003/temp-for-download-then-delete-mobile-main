/// This file defines the `Welcome` widget, which is a `StatelessWidget`.
///
/// It imports necessary packages such as `flutter/material.dart` for Material Design widgets,
/// `get/get.dart` for route management and state management,
/// `lenovo_app/screens/auth/login_page.dart` for the login page of the application, and
/// `lenovo_app/screens/home_page.dart` for the home page of the application.
///
/// The `Welcome` widget returns a `Scaffold` widget, which provides a framework to implement the basic material design visual layout structure.
///
/// The `body` of the `Scaffold` is a `SafeArea` widget, which is a widget that inserts its child by sufficient padding to avoid intrusions by the operating system.
///
/// The `SafeArea` contains a `Column` widget, which then contains a series of widgets including images, texts, and a `FloatingActionButton`.
///
/// The `FloatingActionButton` navigates to the `HomePage` when pressed.
library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenovo_app/screens/auth/login_page.dart';
import 'package:lenovo_app/screens/home_page.dart';

// import 'package:lenovo/login_page.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: Get.width,
                child: Image.asset(
                  'assets/images/wel1.png',
                  fit: BoxFit.fitWidth,
                  height: Get.height * 0.6,
                )),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: Get.width * 0.02, left: Get.width * 0.02),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                      image: AssetImage('assets/images/logo.png'), width: 130),
                  Row(
                    children: [
                      Text(
                        "B2B",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Text(
                        " Lead",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 28),
                      )
                    ],
                  ),
                  Text(
                    "Qualification System",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 28),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Access & Accept",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                      Text(
                        " Leads from Multiple",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    "Sources, Real Time!",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Icon(
          color: Colors.white,
          Icons.arrow_forward,
        ),
      ),
    );
  }
}
