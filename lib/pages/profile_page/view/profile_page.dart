import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:warmindo_user_ui/pages/profile_page/controller/profile_controller.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/popup_veritification.dart';
import 'package:warmindo_user_ui/widget/reusable_dialog.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: ColorResources.primaryColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: screenWidth,
                  color: ColorResources.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          Images.profile,
                          width: 125,
                          height: 125,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Baratha Wijaya',
                        style: nameProfileTextStyle,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '@manusia',
                        style: usernameProfileTextStyle,
                      ),
                      SizedBox(height: screenHeight * 0.002),
                      ElevatedButton(
                        onPressed: () {
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
                          'Edit Profile',
                          style: editProfileTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
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
                            title: Text('Veritification'),
                            trailing: Icon(Icons.info_outlined),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return VerificationStatusPopup();
                                },
                              );
                            },
                          ),
                          SizedBox(height: 30),
                          ListTile(
                            leading: Icon(FontAwesomeIcons.ticket),
                            title: Text('Voucher'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              Get.toNamed(Routes.VOUCHER_PAGE);
                            },
                          ),
                          SizedBox(height: 30),
                          ListTile(
                            leading: Icon(Icons.security),
                            title: Text('Change Password'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              Get.toNamed(Routes.CHANGEPASS_PAGE);
                            },
                          ),
                          SizedBox(height: 30),
                          ListTile(
                            leading: Icon(Icons.policy),
                            title: Text('Policy'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              Get.toNamed(Routes.POLICY_PAGE);
                            },
                          ),
                          SizedBox(height: 30),
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
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
                                      Navigator.of(context).pop();
                                    },
                                    onConfirmPressed: () {
                                      Navigator.of(context).pop();
                                      Get.toNamed(Routes.LOGIN_PAGE);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
