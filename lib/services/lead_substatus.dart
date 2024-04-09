import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchLeadSubstatus() async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/lead/common/lead-substatus?id=4';
  final String token =
      'your_token_here'; // Replace 'your_token_here' with your actual token

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
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load lead substatus data');
  }
}
