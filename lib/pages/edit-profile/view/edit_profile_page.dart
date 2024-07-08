import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_user_ui/pages/verification_profile_page/view/verification_profile_Page.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../routes/AppPages.dart';
import '../../../widget/uploadImage.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());
  final _formKey = GlobalKey<FormState>();
  void getImage(ImageSource source) {
    controller.getImage(source);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
      Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            controller.checkSharedPreference();
          },
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              child: Obx((){
                if (!controller.isConnected.value){
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.5),
                      child: Text(
                        'Tidak ada koneksi internet mohon check koneksi internet anda',
                        style: boldTextStyle,textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                else{
                  return Column(
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
                                child: Text("Edit Profil",style: subheaderRegularStyle,),
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => UploadImage(onImageCapture: getImage,),
                                  );
                                  print(controller.imgProfile);
                                },
                                child: Container(
                                  width: screenWidth,
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding:EdgeInsets.all(5),
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius: BorderRadius.all(Radius.circular(100))
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  child: Obx((){
                                                    if(controller.imgProfile.value == ''){
                                                      return controller.selectedImage.value != null && controller.selectedImage.value!.path.isNotEmpty ? Image.file(
                                                        File(controller
                                                            .selectedImage.value!.path),
                                                        fit: BoxFit.cover,
                                                      ) : Image.asset(
                                                        Images.profile,
                                                        fit: BoxFit.cover,
                                                      );
                                                    }else {
                                                      return controller.selectedImage.value != null && controller.selectedImage.value!.path.isNotEmpty ? Image.file(
                                                        File(controller
                                                            .selectedImage.value!.path),
                                                        fit: BoxFit.cover,
                                                      ) : Image.network(
                                                        controller.imgProfile.value,
                                                        fit: BoxFit.cover,
                                                      );
                                                    }
                                                    // if(controller.imgProfile.value == 'null' && controller.imgProfile.value == null){
                                                    //  return Image.asset(
                                                    //     Images.profile,
                                                    //     fit: BoxFit.cover,
                                                    //   );
                                                    // }else if(controller.imgProfile.value != 'null' && controller.imgProfile.value != null){
                                                    //   return  Image.network(controller.imgProfile.value);
                                                    // }
                                                    // else {
                                                    //   return Image.file(
                                                    //     File(controller.selectedImage.value!.path),
                                                    //     fit: BoxFit.cover,
                                                    //   );
                                                    // }
                                                  }
                                                  ),
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
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: controller.fullNameController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white), // Set border color to white
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white), // Set border color to white
                                  ),
                                  labelText: "Nama Lengkap",
                                  labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                                ),
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
                                Text("Username", style: regularInputTextStyle,),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  controller: controller.usernameController,
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
                                ),
                                const SizedBox(height: 10.0),
                                Text("Email",style: regularInputTextStyle,),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  controller: controller.emailController,style: regularInputTextStyle,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), // Adjust padding here
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),

                                  ),

                                  validator: (value) {
                                    if (value!.contains("@")) {
                                      return null;
                                    }
                                    return "Invalid email address";
                                  },

                                ),
                                const SizedBox(height: 10.0),
                                Text("Nomor Hp",style: regularInputTextStyle,),
                                const SizedBox(height: 10.0),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.PROFILE_VERIFICATION_PAGE);
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: controller.phoneNumberController,
                                      style: regularInputTextStyle,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), // Adjust padding here
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.length < 11) {
                                          return "Nomor Hp tidak valid";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
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
                                        print('berhasil tahap 1');
                                        if(controller.selectedImage.value.path == ''){
                                          controller.editProfile(name: controller.fullNameController.text,username: controller.usernameController.text,email: controller.emailController.text,phone_number: controller.phoneNumberController.text);
                                          print('berhasil tahap 2');
                                        }else{
                                          controller.editProfile(name: controller.fullNameController.text,username: controller.usernameController.text,email: controller.emailController.text,image: controller.selectedImage.value,phone_number: controller.phoneNumberController.text);
                                          print('berhasil tahap 3');
                                        }
                                        // Show a success message or perform other actions
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
                  );
                }
              }
              ),
            ),
          ),
        ),
      ),
        Obx(() {
          if (controller.isLoading.value == true) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],

    );

  }
}
