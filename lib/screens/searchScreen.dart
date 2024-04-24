import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lenovo_app/Widget/appText.dart';
import 'package:lenovo_app/constants/colorConstants.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    // Load search history from storage on initialization
    loadSearchHistory();
  }

  Future<void> loadSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load search history from shared preferences
    searchHistory = prefs.getStringList('searchHistory') ?? [];
    setState(() {});
  }

  Future<void> saveSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save search history to shared preferences
    await prefs.setStringList('searchHistory', searchHistory);
  }

  Future<void> search(String query) async {
    final String encodedQuery = Uri.encodeComponent(query);
    final String apiUrl =
        'https://your-api-url.com/api/search?query=$encodedQuery';

    final String token = AppPersist.getString(AppStrings.token, "");
    final Map<String, String> headers = {
      'Authorization': token,
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        searchResults = List<String>.from(data['records'] ?? []);
        // Add query to search history if not already present
        if (!searchHistory.contains(query)) {
          searchHistory.add(query);
          // Save updated search history
          saveSearchHistory();
        }
      });
    } else {
      print('Failed to search: ${response.statusCode}');
      print(response.body);
    }
  }

  void clearSearchHistory() {
    setState(() {
      searchHistory.clear();
      // Clear search history from storage
      saveSearchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: Get.width * 0.04,
          left: Get.width * 0.04,
          top: Get.height * 0.02,
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
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, size: Get.height * 0.04),
                  ),
                  SizedBox(width: Get.width * 0.03),
                  Expanded(
                    child: Container(
                      height: Get.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xffeaeef5),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (value) => search(value),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () => search(_searchController.text),
                          ),
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
                  onTap: clearSearchHistory,
                  child: AppText(
                      text: "Clear all",
                      color: Colors.red,
                      height: 0.018,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.01),
            Expanded(
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) => ListTile(
                  title: AppText(
                    text: searchHistory[index],
                    color: ColorConstants.greyColor,
                    height: 0.022,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: () => search(searchHistory[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
