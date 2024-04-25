import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';

class EditProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with initial values (if any)
    _fullNameController.text = "Baratha Wijaya Kusuma";
    _emailController.text = "baratha@gmail.com";
    _phoneNumberController.text = "0821-2480-5253";
    _usernameController.text = "@manusia";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    Images.profile,
                    width: 125,
                    height: 125,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Full name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email address is required";
                  }
                  if (!value.contains("@")) {
                    return "Invalid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: ColorResources.secondaryTextColor,
                  minimumSize: Size(211, 46),
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Update profile information
                    print("Full Name: ${_fullNameController.text}");
                    print("Email Address: ${_emailController.text}");
                    print("Phone Number: ${_phoneNumberController.text}");
                    print("Username: ${_usernameController.text}");

                    // Show a success message or perform other actions
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Profile updated successfully!"),
                      ),
                    );
                  }
                },
                child: Text("Edit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
