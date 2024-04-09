import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:lenovo_app/utils/app_persist.dart';
import 'dart:convert';

import 'package:lenovo_app/utils/app_strings.dart';

Future<Map<String, dynamic>> fetchFollowUpLeads() async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/ui/common/follow-up-leads';
  final String token =
      '${AppPersist.getString(AppStrings.token, "")}'; // Replace 'your_token_here' with your actual token

  final Map<String, String> queryParams = {
    'start': '0',
    'size': '4',
  };

  final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

  final Map<String, String> headers = {
    'Authorization': token,
    'compId': '11584',
    'stDtGrEq': '2024-02-16',
    'enDtLsEq': '2024-02-20',
  };

  final response = await http.get(
    uri,
    headers: headers,
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final jsonResponse = json.decode(response.body);
    log('Follow-up leads: $jsonResponse');
    return jsonResponse; // Return the parsed JSON
  } else {
    // If the server did not return a 200 OK response, throw an exception
    log('Failed to load follow-up leads: ${response.body}');
    throw Exception('Failed to load follow-up leads');
  }
}
