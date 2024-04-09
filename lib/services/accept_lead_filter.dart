import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<Map<String, dynamic>> fetchAcceptLeadsListing(
  String sourceIdIn,
  String productIn,
  String purchaseTimeIn,
  String stDtGrEq,
  String enDtLsEq,
) async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/ui/common/accept-leads-listing';
  final String token = AppPersist.getString(
      AppStrings.token, ""); // Replace with your actual token

  final Map<String, String> queryParams = {
    'start': '0',
    'size': '10',
  };

  final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

  final Map<String, String> headers = {
    'Authorization': token,
    'sourceIdIn': sourceIdIn,
    'productIn': productIn,
    'purchaseTimeIn': purchaseTimeIn,
    'stDtGrEq': stDtGrEq,
    'enDtLsEq': enDtLsEq,
  };

  final response = await http.get(
    uri,
    headers: headers,
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON and return it
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load accept leads listing');
  }
}
