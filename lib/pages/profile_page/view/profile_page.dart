import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:warmindo_user_ui/pages/edit-profile/controller/edit_profile_controller.dart';
import 'package:warmindo_user_ui/pages/profile_page/controller/profile_controller.dart';
import 'package:warmindo_user_ui/pages/profile_page/shimmer/profile_shimmer.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/popup_veritification.dart';
import 'package:warmindo_user_ui/widget/reusable_dialog.dart';

class ProfilePage extends StatelessWidget {
  final EditProfileController editProfileController = Get.put(EditProfileController());
  final ProfileController profileController = Get.put(ProfileController());
  ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            profileController.checkConnectivity();
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: screenHeight* 0.08),
              width: screenWidth,
              height: screenHeight * 0.9,
              color: ColorResources.primaryColor,
           child:  Obx((){
             if (!profileController.isConnected.value){
               return Center(
                 child: Container(
                   margin: EdgeInsets.only(top: screenHeight * 0.2),
                   child: Text(
                     'Tidak ada koneksi internet mohon check koneksi internet anda',
                     style: whiteboldTextStyle15,textAlign: TextAlign.center,
                   ),
                 ),
               );
             }
             else{
               return Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Obx((){
                     if (profileController.isLoading.value) {
                       return ProfileShimmer();
                     }else{
                       return Container(
                         margin: EdgeInsets.only(bottom: 20),
                         width: screenWidth,
                         color: ColorResources.transparent,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(8),
                               child: Obx(() {
                                 return Container(
                                   width: 125,
                                   height: 145,
                                   decoration: BoxDecoration(
                                     color: Colors.grey[200],
                                     border: Border.all(width: 5,color: Colors.white60)
                                   ),

                                   child: profileController.image.value == ''
                                       ? Image.network(
                                     'https://ui-avatars.com/api/?background=random&color=ffffff&name=${profileController.txtName.value}&size=128',
                                     width: 125,
                                     height: 125,
                                     fit: BoxFit.cover,
                                     alignment: Alignment.center,
                                   )
                                       : Image.network(
                                     '${profileController.image.value}',
                                     width: 125,
                                     height: 125,
                                     fit: BoxFit.cover,
                                     alignment: Alignment.center,
                                   ),
                                 );
                               }),
                             ),
                             SizedBox(height: 15),
                             Text(
                               profileController.txtName.value,
                               style: nameProfileTextStyle,
                             ),
                             Text(
                               '@${profileController.txtUsername.toLowerCase()}',
                               style: usernameProfileTextStyle,
                             ),
                             SizedBox(height: screenHeight * 0.002),
                             ElevatedButton(
                               onPressed: () async {
                                 editProfileController.selectedImage.value = File('');
                                  editProfileController.fetchUser();
                                 Get.toNamed(Routes.EDITPROFILE_PAGE);
                               },
                               style: ElevatedButton.styleFrom(
                                 minimumSize: Size(133, 30),
                                 padding: EdgeInsets.all(8),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(8.0),
                                 ),
                                 backgroundColor: Colors.black,

                               ),
                               child: Text(
                                 'Edit Profil',
                                 style: editProfileTextStyle,
                               ),
                             ),
                           ],
                         ),
                       );
                     }
                   }),
                   Flexible(
                     child: Container(
                         width: screenWidth,
                         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                         decoration: BoxDecoration(
                           color: ColorResources.wProfileBg,
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(22),
                             topRight: Radius.circular(22),
                           ),
                         ),
                         child:  Column(
                           children: [
                             ListTile(
                               leading: Icon(Icons.person),
                               title: Text('Verifikasi'),
                               trailing: SizedBox(
                                 width: 100, // Adjust the width as needed
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Visibility(
                                       visible: profileController.user_verified.value == '1',
                                       child: Icon(Icons.verified_rounded,color: Colors.black,),
                                     ),
                                     SizedBox(width: 8), // Add some spacing between icons
                                     InkWell(
                                       onTap: () {
                                         showDialog(
                                           context: context,
                                           builder: (BuildContext context) {
                                             return VerificationStatusPopup();
                                           },
                                         );
                                       },
                                       child: Icon(Icons.info_outlined),
                                     ),
                                   ],
                                 ),
                               ),
                             ),


                             Visibility(
                               visible:profileController.isLoginGoogle.value != 'true',
                               child: Column(
                                 children: [
                                   SizedBox(height: 30),
                                   ListTile(
                                     leading: Icon(Icons.security),
                                     title: Text('Ganti Password'),
                                     trailing: Icon(Icons.chevron_right),
                                     onTap: () {
                                       Get.toNamed(Routes.CHANGEPASS_PAGE);
                                     },
                                   ),
                                 ],
                               ),
                             ),
                             SizedBox(height: 30),
                             ListTile(
                               leading: Icon(Icons.policy),
                               title: Text('Kebijakan'),
                               trailing: Icon(Icons.chevron_right),
                               onTap: () {
                                 Get.toNamed(Routes.POLICY_PAGE);
                               },
                             ),
                             SizedBox(height: 30),
                             ListTile(
                               leading: Icon(Icons.logout),
                               title: Text('Keluar'),
                               trailing: Icon(Icons.chevron_right),
                               onTap: () {
                                 showDialog(
                                   context: context,
                                   builder: (BuildContext context) {
                                     return ReusableDialog(
                                       title: "Log Out",
                                       content: "Apakah Kamu yakin ingin logout?",
                                       cancelText: "Tidak",
                                       confirmText: "Iya",
                                       onCancelPressed: () {
                                         Get.back();
                                       },
                                       onConfirmPressed: () {
                                         profileController.logOut();
                                       },
                                       cancelButtonColor:
                                       ColorResources.cancelButttonColor,
                                       confirmButtonColor:
                                       ColorResources.confirmButtonColor,
                                       dialogImage: Image.asset(Images.askDialog),
                                     );
                                   },
                                 );
                               },
                             ),
                           ],
                         )
                     ),
                   ),
                 ],
               );
             }
            },
           ),
            ),
          ),
        ),
      ),
    );
  }
}
