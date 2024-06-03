import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:warmindo_user_ui/pages/onboard_page/controller/onboard_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/widget/reusable_dialog.dart';

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
      body: Obx(() => Column(
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
                          width: 500,
                          height: 500,
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
                    controller.isLastPage.value =
                        index == pageContent.length - 1;
                  },
                ),
              ),

              // Tampilkan tombol skip dan next jika tidak berada di halaman terakhir
              Center(
                child: SmoothPageIndicator(
                    controller: controller.pageController, // PageController
                    count: 3,
                    effect: WormEffect(
                      dotColor: ColorResources.lightTomatoRed,
                      activeDotColor: ColorResources.tomatoRed,
                      spacing: 15,
                      dotHeight: 12,
                      dotWidth: 12,
                    ), // your preferred effect
                    onDotClicked: (index) =>
                        controller.pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        )),
              ),
              Visibility(
                visible: !controller.isLastPage.value,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => controller.pageController.animateToPage(
                            pageContent.length - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease),
                        child: Text('Skip', style: onboardingskip),
                      ),
                          Container(
                             margin: EdgeInsets.only(right: 10),
                            width: 55,
                            height: 49,
                            decoration: BoxDecoration(

                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.tomatoRed, // Warna hitam dengan opasitas 50%
                                  spreadRadius: 0, // Persebaran bayangan
                                  blurRadius: 6, // Kekaburan bayangan
                                  offset: Offset(0,
                                      3), // Geser bayangan (horizontal, vertical)
                                ),
                              ],
                              color: ColorResources.primaryColorLight,
                              borderRadius: BorderRadius.circular(9),
                            ),

                            child: GestureDetector(
                              onTap: () {
                                controller.pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: ColorResources.tomatoRed,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              // Tampilkan tombol register dan login di halaman terakhir
              Visibility(
                visible: controller.isLastPage.value,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child:  ElevatedButton(
                            onPressed: () =>
                                Get.toNamed(Routes.REGISTER_PAGE),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: ColorResources.primaryColorLight,
                              foregroundColor:  Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              side: BorderSide(width: 1.5, color:  Colors.black),
                            ),
                            child: Padding(
                             padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text('Register'),
                            ),
                          ),),
                          SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Get.toNamed(Routes.LOGIN_PAGE),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                side: BorderSide(width: 1.5, color:  Colors.black),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text('Login'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11),
                      ElevatedButton(
                        onPressed: () {
                         showDialog(context: context,
                             builder: (BuildContext context) {
                         return ReusableDialog(title: 'Pesan', content: "Apakah anda yakin ingin masuk sebagai Guest?",
                               cancelText: 'Tidak', confirmText: 'Yakin', onCancelPressed: (){
                             Get.back();
                               }, onConfirmPressed: (){
                                 Get.offAllNamed(Routes.GUEST_NAVIGATOR_PAGE);
                               });
                         });
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorResources.btnonboard,
                          foregroundColor: ColorResources.primaryColorLight,
                          minimumSize: Size(395, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Text('Guest Mode'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
      backgroundColor: controller.currentPage.value == 1
          ? ColorResources.bgonboard
          : Colors.white,
    );
  }
}
