import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:warmindo_user_ui/pages/onboard_page/controller/onboard_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/widget/dot_indicator.dart';

class OnboardPage extends StatelessWidget {
  final OnboardController controller = Get.find();

  final List<Map<String, dynamic>> pageContent = [
    {
      'header': 'Cari Makanan yang kamu sukai',
      'subheader':
      'Hai Pecinta mie Yuk, temukan kenikmatan mie terbaikmu di Warmindo Anggrek Muria Nikmati setiap kelezatan mie kesayangan kamu di Warmindo Anggrek Muria.',
      'image': Images.onboard1,
    },
    {
      'header': 'Tanpa Antre, Tanpa Waktu Terbuang',
      'subheader':
      'Tidak suka antre dan buang-buang waktu? Kami juga tidak! kamu bisa memesan makanan dan minuman kesukaan kamu tanpa harus lelah mengantre lama.',
      'image': Images.onboard2,
    },
    {
      'header': 'Yuk, Jadi Bagian dari Warmindo️',
      'subheader':
      'Jangan lewatkan kesempatan untuk merasakan kelezatan mie istimewa kami! Segera login atau daftar sekarang juga dan nikmati sensasi mie yang luar biasa! Dengan setiap gigitan.',
      'image': Images.onboard3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: pageContent.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      pageContent[index]['image'],
                      fit: BoxFit.fill,
                      width: 450,
                      height: 600,
                    ),
                    SizedBox(height: 20),
                    Text(
                      pageContent[index]['header'],
                      style: onboardingHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      pageContent[index]['subheader'],
                      maxLines: 3,
                      style: onboardingSubHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    // Tampilkan indikator halaman

                  ],
                );
              },
              onPageChanged: (index) {
                controller.isLastPage.value = index == pageContent.length - 1;
              },
            ),
          ),
          SizedBox(height: 20),
          // Tampilkan tombol skip dan next jika tidak berada di halaman terakhir
          Center(
            child:SmoothPageIndicator(
                controller: controller.pageController,  // PageController
                count:  3,
                effect:  ScaleEffect(
                    dotColor: ColorResources.lightTomatoRed,
                    activeDotColor: ColorResources.tomatoRed,
                    spacing: 15,
                    dotHeight: 12,
                    dotWidth: 12
                ),  // your preferred effect
                onDotClicked: (index) => controller.pageController.animateToPage(
                  index, duration: const Duration(milliseconds: 300),  curve: Curves.ease,
                )
            ),
          ),
          Visibility(
            visible: !controller.isLastPage.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => controller.goToPage(pageContent.length - 1),
                  child: Text('Skip',style: onboardingskip,),
                ),
                SizedBox(width: 270),
                IconButton(
                  onPressed: () => controller.pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease),
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          // Tampilkan tombol register dan login di halaman terakhir
          Visibility(
            visible:  controller.isLastPage.value,
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.offAllNamed(Routes.REGISTER_PAGE),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(152, 53),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Register'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => Get.offAllNamed(Routes.LOGIN_PAGE),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(152, 53),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Login'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed('/guest_mode'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(312, 53),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Guest Mode'),
                ),
              ],
            ),
          ),
        ],
      ),) ,

      backgroundColor: controller.currentPage.value == 1
          ? ColorResources.bgonboard
          : Colors.white,
    );
  }
}
