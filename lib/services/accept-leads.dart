import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<Map<String, dynamic>> acceptLeads() async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/lead/common/leadList';
  final String token = AppPersist.getString(AppStrings.token, "");
  final Map<String, String> queryParams = {
    'start': '0',
    'size': '10',
    'statusIn': '8', // Adding statusIn parameter
  };

  final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

  final Map<String, String> headers = {
    'Authorization': token,
  };

  final response = await http.get(
    uri,
    headers: headers,
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final jsonResponse = json.decode(response.body);
    return jsonResponse; // Return the parsed JSON
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load lead list data');
  }
}
