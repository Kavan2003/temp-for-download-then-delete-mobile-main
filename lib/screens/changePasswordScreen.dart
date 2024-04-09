import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool passwordVisible = true;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? newPassword;
  String? confirmPassword;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool validatePassword(String password) {
    bool isValid = password.length >= 8 &&
        password.length <= 20 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#\$%^&*()\-=_+|[\]{};:/?.,<>\s]'));
    return isValid;
  }

  void onSaveButtonPressed() async {
    newPassword = newPasswordController.text;
    confirmPassword = confirmPasswordController.text;

    if (newPassword!.isEmpty || confirmPassword!.isEmpty) {
      showAlertDialog("Warning", "Please fill all the fields.");
    } else if (newPassword != confirmPassword) {
      showAlertDialog("Warning", "Passwords do not match.");
    } else if (!validatePassword(newPassword!)) {
      showAlertDialog("Warning",
          "Please read password policy. Your password does not meet the requirements.");
    } else {
      bool success = await resetPassword(newPassword!);

      if (success) {
        showAlertDialog("Success", "Password changed successfully.");
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else {
        showAlertDialog(
            "Error", "Failed to change password. Please try again later.");
      }
    }
  }

  Future<bool> resetPassword(String newPassword) async {
    // Implement your reset password API call here
    // Example: Make HTTP request to your reset password endpoint
    // Replace this with your actual API call
    try {
      // Mock API call with delay
      await Future.delayed(Duration(seconds: 2));
      // Successful response
      return true;
    } catch (e) {
      // Error handling
      print("Error resetting password: $e");
      return false;
    }
  }

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, size: Get.width * 0.06),
                ),
                Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: Get.width * 0.06)
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Text(
              "New Password",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              obscureText: passwordVisible,
            ),
            SizedBox(height: Get.height * 0.02),
            Text(
              "Confirm Password",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              obscureText: passwordVisible,
            ),
            SizedBox(height: Get.height * 0.01),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Password Policy"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "* Password Policy must be added which are as follows:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                              "1. It must contain min 8 character max 20 character length."),
                          Text(
                              "2. It must contain at least 1 Upper case letter."),
                          Text(
                              "3. It must contain at least 1 lower case letter."),
                          Text(
                              "4. It must contain at least 1 special character (!@\"#\$%^&*()-=+)."),
                          Text("5. It must contain at least 1 number."),
                          Text("6. It should not contain any white spaces."),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Password Policy',
                style: TextStyle(
                  color: Colors.blue, // Change color as needed
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.59),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.grey, width: 2.0),
                        top: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Cancel button pressed
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: onSaveButtonPressed,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
