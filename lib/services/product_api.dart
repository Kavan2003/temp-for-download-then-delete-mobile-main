import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<String> fetchProduct() async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/ui/common/product';
  final String token = AppPersist.getString(AppStrings.token, "");
  final Map<String, String> headers = {
    'Authorization': token,
  };

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final jsonResponse = json.decode(response.body);
    print(jsonResponse); // Output the response
    return response.body;
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load product data');
  }
}
