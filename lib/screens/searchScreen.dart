import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lenovo_app/Widget/appText.dart';
import 'package:lenovo_app/constants/colorConstants.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    // Call the search API function when the screen is initialized
    search();
  }

  Future<void> search() async {
    final String apiUrl =
        'https://clms-lenovo1.hashconnect.in/api/ui/search?start=0&size=20&search=Warana%20Arana&page=lead';
    final String token = AppPersist.getString(AppStrings.token, "");
    final Map<String, String> headers = {
      'Authorization': token,
    };

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the response body
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        searchResults = List<String>.from(data['records'] ?? []);
      });
    } else {
      // If the server did not return a 200 OK response, print an error message
      print('Failed to search: ${response.statusCode}');
      print(response.body);
    }
  }

  void clearSearchResults() {
    setState(() {
      searchResults.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: Get.width * 0.04,
          left: Get.width * 0.04,
          top: Get.height * 0.02, // Account for system status bar
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            SizedBox(
              height: Get.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: Get.height * 0.04,
                      )),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Expanded(
                    child: Container(
                      height: Get.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xffeaeef5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: 'Type here',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.1),
            Divider(),
            SizedBox(height: Get.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                    text: "Recent Search",
                    height: 0.018,
                    fontWeight: FontWeight.w500),
                GestureDetector(
                  onTap: clearSearchResults,
                  child: AppText(
                      text: "Clear all",
                      color: Colors.red,
                      height: 0.018,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.01),
            for (String result in searchResults)
              AppText(
                  text: result,
                  color: ColorConstants.greyColor,
                  height: 0.022,
                  fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
