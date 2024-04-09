import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<String> fetchPurchaseTimeFrame() async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/ui/common/purchase-time-frame';
  final String token = AppPersist.getString(AppStrings.token, "");

  final Map<String, String> headers = {
    'Authorization': token,
  };

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: headers,
  );
  log(response.body);
  final jsonResponse = json.decode(response.body);
  if (jsonResponse["status"] == "SUCCESS") {
    // log("messagehere");

    // print(jsonResponse); // Output the response

    return response.body;
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load purchase time frame data');
  }
}
