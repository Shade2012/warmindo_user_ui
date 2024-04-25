import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorResources.profileBg,
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.profilebg),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              // Container 1 (Bagian atas)
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: screenWidth,
                height: screenHeight * 0.3,
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
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        // Aksi saat tombol ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(133, 30),
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        backgroundColor: ColorResources.primaryColor,
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
              // Container 2 (Bagian bawah)
              Expanded(
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorResources.wProfileBg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  child: ListView(
                    children: [
                      SizedBox(height: 40),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Veritification'),
                        trailing: Icon(Icons.info_outlined),
                        onTap: () {
                          // Aksi saat item di tap
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
                          // Aksi saat item di tap
                        },
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.policy),
                        title: Text('Policy'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          // Aksi saat item di tap
                        },
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          // Aksi saat item di tap
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
