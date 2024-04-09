import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

class ProfileServices {
  static Future<String> uploadProfileImage(
      String imagePath, String token) async {
    try {
      var uri =
          Uri.parse("https://clms-lenovo1.hashconnect.in/api/admin/profile");

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] =
            '${AppPersist.getString(AppStrings.token, "")}'
        ..files.add(await http.MultipartFile.fromPath('files', imagePath));

      var response = await request.send();

      if (response.statusCode == 200) {
        // If the request is successful, return the response body
        return await response.stream.bytesToString();
      } else {
        // If the request is unsuccessful, throw an error
        throw Exception(
            'Failed to upload profile image: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the process
      throw Exception('Error uploading profile image: $error');
    }
  }

  static Future<Map<String, dynamic>> fetchUserProfile(
      String token, int id) async {
    try {
      var uri = Uri.parse(
          "https://clms-lenovo1.hashconnect.in/api/ui/common/user-profile?id=$id");

      var response = await http.get(
        uri,
        headers: <String, String>{
          'Authorization':
              '${AppPersist.getString(AppStrings.token, "")}', // Replace 'your_token_here' with your actual token
        },
      );

      if (response.statusCode == 200) {
        // If the request is successful, parse the response body and return the user profile data
        return json.decode(response.body);
      } else {
        // If the request is unsuccessful, throw an error
        throw Exception(
            'Failed to fetch user profile data: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the process
      throw Exception('Error fetching user profile data: $error');
    }
  }
}
