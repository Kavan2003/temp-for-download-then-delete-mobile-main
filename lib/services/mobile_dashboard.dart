import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<Map<String, dynamic>> fetchMobileDashboardData() async {
  // Define the endpoint URL
  final String baseUrl =
      'https://clms-lenovo1.hashconnect.in/api/ui/common/mobile-dashboard';

  // Define the query parameters
  final Map<String, String> queryParams = {
    'stDtGrEq': '2024-03-01 00:00:00',
    'enDtLsEq': '2024-03-04 23:59:59'
  };

  // Build the full URL with query parameters
  final Uri uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

  // Define the headers
  final Map<String, String> headers = {
    'Authorization': "${AppPersist.getString(AppStrings.token, "")}"
        ''
  };

  try {
    // Make the GET request
    final http.Response response = await http.get(uri, headers: headers);

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> data = jsonDecode(response.body);
      log('Mobile dashboard data: $data');
      return data;
    } else {
      // If the request was not successful, throw an error
      throw Exception('Failed to fetch mobile dashboard data${response.body}');
    }
  } catch (error) {
    // If an error occurs during the request, throw an error
    throw Exception('Error fetching mobile dashboard data: $error');
  }
}
