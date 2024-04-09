import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<void> updateLeadSubstatus() async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/lead/common/lead-substatus?id=4';
  final String token = AppPersist.getString(
      AppStrings.token, ""); // Replace 'your_token_here' with your actual token

  final Map<String, String> headers = {
    'Authorization': token,
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> body = {
    'id': 11231,
    'status': 4,
    'substatus': 25,
    'user_id': '110',
  };

  final response = await http.put(
    Uri.parse(apiUrl),
    headers: headers,
    body: json.encode(body),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, print a success message
    print('Lead substatus updated successfully');
  } else {
    // If the server did not return a 200 OK response, print an error message
    print('Failed to update lead substatus: ${response.statusCode}');
    print(response.body);
  }
}
