import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';
import 'package:lenovo_app/utils/navigations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      var token = AppPersist.getString(AppStrings.token, "");
      log(AppPersist.getString(AppStrings.token, ""));
      log("message");
      log(AppPersist.getString(AppStrings.userName, ''));
      debugPrint("~~~ token : ${token}");
      if (AppPersist.getString(AppStrings.token, '').isEmpty) {
        NavigationClass().navToWelcomeScreen(context);
      } else {
        NavigationClass().navToHomeScreen(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
