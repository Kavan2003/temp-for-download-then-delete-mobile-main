import 'package:http/http.dart' as http;
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<void> search() async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/ui/search?start=0&size=20&search=Warana%20Arana&page=lead';
  final String token = AppPersist.getString(AppStrings.token, "");
  final Map<String, String> headers = {
    'Authorization': token,
  };

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, print the response body
    print('Response: ${response.body}');
  } else {
    // If the server did not return a 200 OK response, print an error message
    print('Failed to search: ${response.statusCode}');
    print(response.body);
  }
}
