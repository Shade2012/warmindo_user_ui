import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/profile_page/controller/profile_controller.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  ProfileShimmer({super.key,});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: screenWidth,
        color: ColorResources.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Skeleton(height: 125,width: 125,radius: 8),
            const SizedBox(height: 15),
            const Skeleton(height: 30,width: 150,radius: 2),
            Text(
              profileController.txtName.value,
              style: nameProfileTextStyle,
            ),
            const Skeleton(height: 30,width: 125,radius: 2),
            SizedBox(height: screenHeight * 0.002),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.EDITPROFILE_PAGE);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(133, 30),
                padding: const EdgeInsets.all(8),
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
    );
  }
}
