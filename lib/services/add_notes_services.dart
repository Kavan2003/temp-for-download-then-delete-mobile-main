import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';

void main() {
  runApp(ProfileScreen());
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Account Info'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'), // Placeholder image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          showImageUploadDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality to edit profile
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ProfileField(
                title: 'First Name',
                value: 'John', // Replace with actual user data
              ),
              ProfileField(
                title: 'Last Name',
                value: 'Doe', // Replace with actual user data
              ),
              ProfileField(
                title: 'Mobile Number',
                value: '1234567890', // Replace with actual user data
              ),
              ProfileField(
                title: 'Email Address',
                value: 'john.doe@example.com', // Replace with actual user data
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String title;
  final String value;

  const ProfileField({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

Future<void> showImageUploadDialog(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    // Set the picked image as the profile picture
    // This is where you would upload the image to the server
    // and update the profile image URL
    // For now, let's just print the path of the picked file
    print('Picked file path: ${pickedFile.path}');
  }
}

Future<void> addNote(int leadId, String note) async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/lead/common/mobile-add-note';
  final String token = '${AppPersist.getString(AppStrings.token, "")}';
  final int userId = int.parse(AppPersist.getString(AppStrings.userId, ""));

  final Map<String, String> headers = {
    'Authorization': token,
    'Content-Type': 'application/json',
  };

  final String requestBody = json.encode({
    "lead_id": leadId,
    "user_id": userId, // Use the dynamically obtained user ID
    "interaction_notes": note
  });

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Parse the response JSON
    var responseData = json.decode(response.body);
    if (responseData['status'] == 'SUCCESS') {
      print('Note added successfully to lead $leadId');
      // Optionally, you can return the ID of the added note
      // int noteId = responseData['data']['id'];
    } else {
      print('Failed to add note: ${responseData['status']}');
    }
  } else {
    print('Failed to add note: ${response.statusCode}');
    print(response.body);
  }
}

Future<List<String>> fetchNotes(int leadId) async {
  final String apiUrl =
      'https://clms-lenovo1.hashconnect.in/api/lead/common/mobile-add-note?id=$leadId';
  final String token = '${AppPersist.getString(AppStrings.token, "")}';
  // ignore: unused_local_variable
  final int userId = int.parse(AppPersist.getString(AppStrings.userId, ""));

  final Map<String, String> headers = {
    'Authorization': token,
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the notes data
      var responseData = json.decode(response.body);
      List<String> notes = []; // Initialize the notes list
      for (var record in responseData['records']) {
        notes.add(record['interaction_notes']);
      }
      print('Notes fetched successfully: $notes');
      return notes;
    } else {
      // If the server did not return a 200 OK response, print the error message
      print('Failed to fetch notes: ${response.statusCode}');
      print(response.body);
      throw Exception('Failed to fetch notes: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching notes: $e');
    throw e; // Re-throw the exception to handle it where fetchNotes is called
  }
}

Future<void> showEditTextDialog(
  BuildContext context,
  int leadId,
  Function(String) onNoteAdded,
) async {
  String editText = '';
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        // Replace with user profile photo
                        backgroundImage: AssetImage('assets/user-image.png'),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              editText = value;
                            });
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Add note here',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () async {
                          if (editText.isNotEmpty) {
                            // Add the lead ID to the addNote function call
                            await addNote(leadId, editText);
                            onNoteAdded(editText);
                            setState(() {
                              editText = '';
                            });
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
