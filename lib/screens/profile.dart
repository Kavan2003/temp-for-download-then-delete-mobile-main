import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenovo_app/Widget/appText.dart';
import 'package:lenovo_app/constants/colorConstants.dart';
import 'package:lenovo_app/constants/imageConstants.dart';
import 'package:lenovo_app/screens/auth/login_page.dart';
import 'package:lenovo_app/screens/user_profile_info.dart';
import 'package:lenovo_app/utils/app_persist.dart';
import 'package:lenovo_app/utils/app_strings.dart';
import 'changePasswordScreen.dart';
import 'package:lenovo_app/services/profile_service.dart'; // Importing the profile services

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};
  late String profileImageUrl = '';
  late String firstName = '';
  late String lastName = '';
  late String mobileNumber = '';
  late String emailAddress = '';

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user profile data when the widget initializes
    fetchUserProfileData();
  }

  Future<void> fetchUserProfileData() async {
    try {
      // Fetch user profile data using the provided token and user ID
      Map<String, dynamic> response = await ProfileServices.fetchUserProfile(
          '${AppPersist.getString(AppStrings.token, "")}',
          110); // Assuming user ID is 110
      // Update the state variables with the fetched user data
      setState(() {
        userData = response['records'][0]; // Assigning the fetched user data
      });
    } catch (error) {
      // Handle errors here
      print('Error fetching user profile: $error');
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
      // 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJXIiwiVVNFUl9JRCI6MTEwLCJVU0VSTkFNRSI6IlciLCJQUklWSUxFR0VTIjpbIkxlYWRfTGlzdGluZyIsIkxlYWRfTGlzdGluZ19TdGF0dXNfdXBkYXRlIiwiTGVhZF9MaXN0aW5nX1ZpZXdfU2luZ2xlX0xlYWQiLCJGb2xsb3dfVXBfTGlzdGluZyIsIlJlcG9ydHMiLCJTdGF0dXNfVXBkYXRlIiwiTWFzdGVyX3ZpZXciLCJDb21wYW55X2xpc3RpbmdfRmlsdGVyIiwidXNlci1wcm9maWxlIiwibW9iaWxlLWRhc2hib2FyZCIsInVuaXZlcnNhbC1zZWFyY2giLCJtb2JpbGUtYWRkLW5vdGUiXSwiUk9MRSI6IlNBTEVfUEVSU09OIiwiaWF0IjoxNzExNzEzMjU2LCJleHAiOjE3MTE3MTc1NzZ9.77xqf2kCIPl-2dbuioMEKAJv3TXKTYDqu91UH9yvW8E';

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
    // Show profile image in a popup dialog
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
  }

  Future<void> logout() async {
    // Example: Clear user data stored in shared preferences or any other storage
    // await SharedPreferences.getInstance().then((prefs) {
    //   prefs.remove('isLoggedIn');
    // });

    // Using GetX to navigate to Login Page and remove all previous routes
    Get.offAll(
        () => LoginPage()); // Replace LoginPage with your login page widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(right: Get.width * 0.04, left: Get.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: Get.width * 0.06,
                    )),
                AppText(
                    text: "Profile",
                    height: 0.022,
                    fontWeight: FontWeight.w700),
                SizedBox(
                  width: Get.width * 0.06,
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Image.network(
                    //   profileImageUrl,
                    //   height: Get.height * 0.07,
                    // ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Welcome",
                          height: 0.019,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.greyColor,
                        ),
                        AppText(
                            text: userData['first_name'] ?? firstName,
                            // Displaying the fetched first name
                            height: 0.02,
                            fontWeight: FontWeight.w500),
                        AppText(
                            text: userData['last_name'] ?? lastName,
                            // Displaying the fetched last name
                            height: 0.02,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    await logout();
                  },
                  child: Icon(
                    Icons.logout_sharp,
                    size: Get.width * 0.06,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Divider(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImageConstants.accoutInfo,
                      height: Get.height * 0.05,
                    ),
                    SizedBox(
                      width: Get.width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ProfileScreen());
                      },
                      child: Row(
                        children: [
                          AppText(
                            text: "Account Info",
                            height: 0.02,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Divider(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            AppText(
                text: "Security",
                height: 0.022,
                color: ColorConstants.greyColor,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: Get.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Get.to(ChangePasswordScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        ImageConstants.password,
                        height: Get.height * 0.05,
                      ),
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      AppText(
                          text: "Password",
                          height: 0.02,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Divider(),
            SizedBox(
              height: Get.height * 0.02,
            ),
            AppText(
                text: "Preference",
                height: 0.022,
                color: ColorConstants.greyColor,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImageConstants.notif,
                      height: Get.height * 0.05,
                    ),
                    SizedBox(
                      width: Get.width * 0.04,
                    ),
                    AppText(
                        text: "Notification",
                        height: 0.02,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImageConstants.pp,
                      height: Get.height * 0.05,
                    ),
                    SizedBox(
                      width: Get.width * 0.04,
                    ),
                    AppText(
                        text: "Privacy & Policy",
                        height: 0.02,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
