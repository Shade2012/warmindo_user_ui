import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class EditProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Initialize controllers with initial values (if any)
    _fullNameController.text = "Baratha Wijaya Kusuma";
    _emailController.text = "baratha@gmail.com";
    _phoneNumberController.text = "0821-2480-5253";
    _usernameController.text = "@manusia";

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorResources.primaryColor, // Set grey background color here
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Center(
                      child: Text("Edit Profile",style: subheaderRegularStyle,),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: screenWidth,
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.grey.shade200,
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: AssetImage(Images.profile),
                                  ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(Icons.camera_alt_outlined, color: Colors.black),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 3,
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            50,
                                          ),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(2, 4),
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 3,
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Set border color to white
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Set border color to white
                        ),
                        labelText: "Full Name",
                        labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear, color: Colors.white), // Set clear icon color to white
                          onPressed: () {
                            _fullNameController.clear(); // Clear text when icon is pressed
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Full name is required";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white), // Set text color to white
                    ),

                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white, // Set white background color here
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      Text("Email",style: regularInputTextStyle,),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _emailController,style: regularInputTextStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), // Adjust padding here
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear, color: Colors.black), // Set clear icon color to white
                            onPressed: () {
                              _emailController.clear(); // Clear text when icon is pressed
                            },
                          ),
                        ),

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
                      const SizedBox(height: 10.0),
                      Text("Nomor Hp",style: regularInputTextStyle,),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _phoneNumberController,style: regularInputTextStyle,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), // Adjust padding here
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear, color: Colors.black), // Set clear icon color to white
                            onPressed: () {
                              _phoneNumberController.clear(); // Clear text when icon is pressed
                            },
                          ),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nomor Hp di perlukan";
                          }
                          if (value.length < 11) {
                            return "Nomor Hp tidak valid";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Text("Username", style: regularInputTextStyle,),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _usernameController,
                        enabled: false, // Make the field readonly
                        style: regulargreyText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username is required";
                          }
                          // Validation logic if needed
                          return null;
                        },
                        onChanged: (value) {
                          // Force input to lowercase
                          _usernameController.value = _usernameController.value.copyWith(
                            text: value.toLowerCase(),
                            selection: TextSelection.collapsed(offset: value.length),
                          );
                        },
                      ),

                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
