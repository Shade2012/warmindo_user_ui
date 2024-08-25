import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/AppPages.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/reusable_dialog.dart';

class GuestProfilePage extends StatelessWidget {
  const GuestProfilePage({super.key});

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
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: screenWidth,
                  color: ColorResources.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            Images.guest,
                            width: 125,
                            height: 125,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Guest',
                        style: nameProfileTextStyle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '@guest',
                        style: usernameProfileTextStyle,
                      ),
                      SizedBox(height: screenHeight * 0.002),

                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: screenHeight * 0.6,
                    width: screenWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                    decoration: const BoxDecoration(
                      color: ColorResources.wProfileBg,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child:  Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.policy),
                          title: const Text('Policy'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Get.toNamed(Routes.POLICY_PAGE);
                          },
                        ),
                        const SizedBox(height: 30),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          trailing: const Icon(Icons.chevron_right),
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
                                   Get.back();
                                    Get.offAllNamed(Routes.ONBOARD_PAGE);
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
