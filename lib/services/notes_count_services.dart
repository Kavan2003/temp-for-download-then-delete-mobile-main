import 'package:http/http.dart' as http;
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<void> getNotesCount() async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/lead/common/mobile-add-note?id=11106';
  final String token = AppPersist.getString(
      AppStrings.token, ""); // Replace 'your_token_here' with your actual token

  final Map<String, String> headers = {
    'Authorization': token,
    'Content-Type': 'application/json',
  };

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, print the notes count
    print('Notes count: ${response.body}');
  } else {
    // If the server did not return a 200 OK response, print the error message
    print('Failed to get notes count: ${response.statusCode}');
    print(response.body);
  }
}
