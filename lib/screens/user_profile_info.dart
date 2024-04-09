import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:lenovo_app/services/profile_service.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart'; // Import ProfileServices class

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String profileImageUrl = '';
  late String firstName = '';
  late String lastName = '';
  late String mobileNumber = '';
  late String emailAddress = '';

  @override
  void initState() {
    super.initState();
    // Initialize profile data
    fetchUserProfileData();
  }

  Future<void> fetchUserProfileData() async {
    try {
      // Replace the token and user ID with actual values
      String token = AppPersist.getString(AppStrings.token, "");
      int userId = 110;
      // TODO: Replace the token and user ID with actual values

      // Fetch user profile data using ProfileServices
      Map<String, dynamic> userData =
          await ProfileServices.fetchUserProfile(token, userId);
      log(userData.toString());

      setState(() {
        firstName = userData['records'][0]['first_name'];
        lastName = userData['records'][0]['last_name'];
        mobileNumber = userData['records'][0]['whatsapp'];
        emailAddress = userData['records'][0]['email'];
        profileImageUrl = userData['records'][0]['profile_url'];
      });
    } catch (error) {
      print('Error fetching user profile data: $error');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Upload the picked image as the profile picture
      await uploadProfileImage(pickedFile.path);
    }
  }

  Future<void> uploadProfileImage(String imagePath) async {
    try {
      // Replace the token with actual value
      String token = AppPersist.getString(AppStrings.token, "");
      // Upload profile image using ProfileServices
      String imageUrl =
          await ProfileServices.uploadProfileImage(imagePath, token);

      setState(() {
        profileImageUrl = imageUrl;
      });
    } catch (error) {
      print('Error uploading profile image: $error');
    }
  }

  void _viewProfileImage() {
    if (profileImageUrl.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Image.network(profileImageUrl),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    } else {
      print('Profile image URL is empty or null.');
      // Display a message to the user or handle this scenario as needed
    }
  }

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
                    if (profileImageUrl != '')
                      GestureDetector(
                        onTap: _viewProfileImage,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(profileImageUrl),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _pickImage,
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
                value: firstName,
              ),
              ProfileField(
                title: 'Last Name',
                value: lastName,
              ),
              ProfileField(
                title: 'Mobile Number',
                value: mobileNumber,
              ),
              ProfileField(
                title: 'Email Address',
                value: emailAddress,
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
              value ?? '',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
