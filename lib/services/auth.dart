import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lenovo_app/utils/app_strings.dart';

import '../utils/app_persist.dart';

class AuthServices {
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  checkUserValidFun(Map<String, dynamic> param) async {
    try {
      Uri url = Uri.parse(AppStrings.baseUrl + AppStrings.loginEndPoint);
      Map<String, dynamic> body = {"un": param['un'], "valUsr": true};

      final response =
          await http.post(headers: headers, url, body: jsonEncode(body));

      debugPrint("response : ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      return {"status": "ERROR", "desc": "$e"};
    }
  }

  generateOtp(Map<String, dynamic> param) async {
    try {
      Uri url = Uri.parse(AppStrings.baseUrl + AppStrings.loginEndPoint);
      Map<String, dynamic> body = {"un": param['un'], "needOtp": true};

      final response =
          await http.post(headers: headers, url, body: jsonEncode(body));

      debugPrint("response : ${response.body}");
      return response.body;
    } catch (e) {
      return {"status": "ERROR", "desc": "$e"};
    }
  }

  loginFun(Map<String, dynamic> param) async {
    try {
      Uri url = Uri.parse(AppStrings.baseUrl + AppStrings.loginEndPoint);
      Map<String, dynamic> body = {};

      if (param.keys.contains('otp')) {
        body = {
          "un": param['un'],
          "otp": param['otp'],
          "refId": param['refId']
        };
      } else {
        body = {
          "un": param['un'],
          "pwd": param['pwd'],
        };
      }

      final response =
          await http.post(headers: headers, url, body: jsonEncode(body));

      debugPrint("response : ${response.body}");

      var data = jsonDecode(response.body);

      if (data["status"] == "FAILED") {
        return "";
      }

      await AppPersist.setString(
          AppStrings.userId, "${data['data']['userId']}");
      await AppPersist.setString(AppStrings.role, "${data['data']['role']}");
      await AppPersist.setString(
          AppStrings.userName, "${data['data']['userName']}");

      await AppPersist.setString(AppStrings.token, "${data['data']['token']}");
      await AppPersist.setString(
          AppStrings.privileges, "${data['data']['privileges']}");
      await AppPersist.setString(
          AppStrings.userimage, "${data['data']['profile']}");
      await AppPersist.setString(AppStrings.role, "${data['data']['role']}");

      // print(
      //     "~~~ Type : ${data['data']['privileges'].runtimeType} ::: ${data['data']['privileges']}");
      //
      // var userId = AppPersist.getString(AppStrings.userId, '');
      // var role = AppPersist.getString(AppStrings.role, '');
      // var userName = AppPersist.getString(AppStrings.userName, '');
      var token = AppPersist.getString(AppStrings.token, '');
      log("message os tokken $token");
      // var privileges = AppPersist.getString(AppStrings.privileges, '');
      // //
      // print('userId: $userId');
      // print('role: $role');
      // print('userName: $userName');
      print('~~~ token saved: $token');
      // print('privileges: $privileges');

      print("~~~ data 1: ");
      log(response.body);
      return response.body;
    } catch (e) {
      return {"status": "ERROR", "desc": "$e"};
    }
  }
}
