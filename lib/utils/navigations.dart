import 'package:flutter/material.dart';
import 'package:lenovo_app/screens/auth/login_page.dart';
import 'package:lenovo_app/screens/welcome.dart';
import 'package:lenovo_app/screens/home_page.dart';
import 'package:lenovo_app/screens/all_leads_page.dart';
import 'package:lenovo_app/screens/accepted_leads_page.dart';
import 'package:lenovo_app/screens/new_leads_page.dart';
import 'package:lenovo_app/screens/follow_up_page.dart';
import 'package:lenovo_app/screens/profile.dart';

class NavigationClass {
  navToHomeScreen(context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const HomePage()), (route) => false);
  }

  navToWelcomeScreen(context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const Welcome()), (route) => false);
  }

  navToProfileScreen(context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ProfilePage()),
        (route) => false);
  }

  navToLoginPage(context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
  }
}
