import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

Future<void> resetPassword(String token, String newPassword) async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/admin/resetPwd';

  // Prepare the request body
  Map<String, String> requestBody = {
    'newPwd': newPassword,
    'confirmPwd': newPassword,
  };

  // Prepare the request headers
  Map<String, String> requestHeaders = {
    'Authorization': token,
    'Content-Type': 'application/json',
  };

  try {
    // Make the POST request
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: requestHeaders,
      body: jsonEncode(requestBody),
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      print('Password reset successfully');
    } else {
      print('Failed to reset password: ${response.statusCode}');
    }
  } catch (error) {
    print('Error resetting password: $error');
  }
}

void main() async {
  String token =
      '${AppPersist.getString(AppStrings.token, "")}'; // Replace with your actual token
  String newPassword =
      'your_new_password_here'; // Replace with the new password

  await resetPassword(token, newPassword);
}
