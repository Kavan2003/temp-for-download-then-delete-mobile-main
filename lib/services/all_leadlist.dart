import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<List<dynamic>> fetchLeadData(int start, int size) async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/lead/common/leadList';
  final String token = AppPersist.getString(AppStrings.token, "");

  // If start is greater than 0, we want to restart from the beginning
  if (start > 0) {
    start = 0;
  }

  final Map<String, String> queryParams = {
    'start': '$start',
    'size': '$size',
  };

  final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

  final Map<String, String> headers = {
    'Authorization': token,
  };

  try {
    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final jsonResponse = json.decode(response.body);
      return jsonResponse['records'];
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load lead list data: ${response.statusCode}');
    }
  } catch (e) {
    // Catch any error during the HTTP request
    print('Error fetching lead data: $e');
    throw Exception('Failed to load lead list data: $e');
  }
}
