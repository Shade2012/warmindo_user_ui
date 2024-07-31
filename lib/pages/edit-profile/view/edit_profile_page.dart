import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/edit-profile/widget/textform.dart';
import 'package:warmindo_user_ui/pages/verification_profile_page/view/verification_profile_Page.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../routes/AppPages.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
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
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                child: Obx(() {
                  if (!controller.isConnected.value) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.5),
                        child: Text(
                          'Tidak ada koneksi internet mohon check koneksi internet anda',
                          style: boldTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else
                  {
                    return Column(
                      children: [
                        Container(
                          color: ColorResources.primaryColor, // Set grey background color here
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: screenWidth * 0.56,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          Get.toNamed(Routes.BOTTOM_NAVBAR);
                                        },
                                          child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)),
                                      Center(
                                        child: Text(
                                          "Edit Profil",
                                          style: subheaderRegularStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => UploadImage(onImageCapture: getImage,),
                                    );
                                  },
                                  child: Container(
                                    width: screenWidth,
                                    child: Column(
                                      children: [
                                        Center(
                                            child:Stack(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius: BorderRadius.all(Radius.circular(100))),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                                child: Obx(() {
                                                  if (controller.imgProfile.value == '') {
                                                    return controller.selectedImage.value != null && controller.selectedImage.value!.path.isNotEmpty
                                                        ? Image.file(File(controller.selectedImage.value!.path), fit: BoxFit.cover,) : Image.network('https://ui-avatars.com/api/?background=random&color=ffffff&name=${controller.txtName.value}&size=128',fit: BoxFit.cover, );
                                                  } else{
                                                    return controller.selectedImage.value != null &&
                                                            controller.selectedImage.value!.path.isNotEmpty ?
                                                    Image.file(File(controller.selectedImage.value!.path), fit: BoxFit.cover,)
                                                        : Image.network('https://warmindo.pradiptaahmad.tech/image/${controller.imgProfile.value}', fit: BoxFit.cover,
                                                    // Image.network(controller.imgProfile.value, fit: BoxFit.cover,
                                                          );
                                                  }
                                                }),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 1,
                                              right: 1,
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.black),
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 3,
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(50,),
                                                    ),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: Offset(2, 4),
                                                        color: Colors.black.withOpacity(0.3,),
                                                        blurRadius: 3,
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child:
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20.0),
                                myTextFormField(TextInputType.text, 'Nama Lengkap', controller.fullNameController, regulargreyText, 3),
                                myTextFormField(TextInputType.text, 'Username', controller.usernameController, regulargreyText, 3),
                                myTextFormField(TextInputType.emailAddress, 'Email', controller.emailController, regulargreyText, 1),
                                Container(
                                  width: screenWidth,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Obx(() {
                                          if(controller.txtNomorHp.value == ''){
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(Routes.PROFILE_VERIFICATION_PAGE, arguments: {'isEdit': false.obs,},);
                                              },
                                              child: AbsorbPointer(
                                                child:
                                                myTextFormField(TextInputType.phone, 'Nomor Hp', controller.phoneNumberController, regulargreyText, 0),
                                              ),
                                            );
                                          }else{
                                            return GestureDetector(
                                              onTap: () {
                                                if(controller.user_phone_verified.value != ''){
                                                  Get.toNamed(Routes.PROFILE_VERIFICATION_PAGE, arguments: {'isEdit': true.obs,},);
                                                }else{
                                                  Get.toNamed(Routes.PROFILE_VERIFICATION_PAGE, arguments: {'isEdit': false.obs,},);
                                                }
                                              },
                                              child: AbsorbPointer(
                                                child: myTextFormField(TextInputType.phone, 'Nomor Hp', controller.phoneNumberController, regulargreyText, 0),
                                              ),
                                            );
                                          }
                                        }),
                                      ),
                                      Container(
                                        width: screenWidth * 0.3,
                                          margin: EdgeInsets.only(left: 10),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if(controller.user_phone_verified.value == ''){
                                              Get.toNamed(Routes.VERITIFICATION_PAGE,arguments: {'isLogged': true.obs,});
                                              }else{
                                                Get.snackbar('Pesan', 'Nomor Hp sudah terverifikasi',backgroundColor: Colors.white);
                                              }
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Text(
                                                  'Verifikasi',
                                                  style: whiteboldTextStyle15,
                                                )),
                                            style: redeembutton(),
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Center(
                                  child: ElevatedButton(
                                    style:black_secWhite(),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        print('berhasil tahap 1');
                                        if (controller.selectedImage.value?.path == '') {
                                          await controller.editProfile(name: controller.fullNameController.text, username: controller.usernameController.text, email: controller.emailController.text,);
                                          print('image ada');
                                        } else {
                                        await controller.editProfile(name: controller.fullNameController.text, username: controller.usernameController.text, email: controller.emailController.text, image: controller.selectedImage.value,);
                                        print('image saat ini : ${controller.selectedImage.value}');
                                          controller.selectedImage.value = File('');
                                        print('image setelah proses kossong : ${controller.selectedImage.value}');
                                          print('image kosong');
                                        }
                                      }
                                    },
                                    child: Container(
                                      width:double.infinity,
                                        child: Center(child: Text("Edit"))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
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
