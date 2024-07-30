import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/home_controller.dart';
import 'package:warmindo_user_ui/pages/home_page/shimmer/homeshimmer.dart';
import 'package:warmindo_user_ui/pages/home_page/view/home_snack.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';
import 'package:warmindo_user_ui/widget/cart.dart';
import 'package:warmindo_user_ui/widget/makanan_widget.dart';
import 'package:warmindo_user_ui/widget/reusable_card.dart';
import '../../../common/model/menu_list_API_model.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/minuman_widget.dart';
import '../../../widget/rounded_image.dart';
import '../../../widget/snack_widget.dart';
import '../../detail-menu_page/view/detail_menu_page.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.scheduleController.fetchSchedule();
            await controller.fetchProduct();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),// Wrap with SingleChildScrollView
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Obx(() {
                if (!controller.isConnected.value) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.4),
                      child: Text(
                        'Tidak ada koneksi internet mohon check koneksi internet anda',
                        style: boldTextStyle,textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                if (controller.isLoading.value) {
                  return HomeSkeleton();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Status Toko: ',style: bold17,),
                        Text( controller.scheduleController.jadwalElement[0].is_open ? 'Buka' : 'Tutup',style: bold17,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text("Selamat Pagi", style: regularTextStyle),
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Text(
                        controller.txtUsername.value.toLowerCase().substring(0, 1).toUpperCase() +
                            controller.txtUsername.value.toLowerCase().substring(1),
                        style: boldTextStyle2,
                      ),
                    ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MakananWidget(false),
                      MinumanWidget(false),
                      SnackWidget(false),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                        items: [
                          RoundedImage(
                            imageUrl: Images.promo1,
                            onPressed: () {
                              controller.navigateToFilteredMenu(context, 10000);
                            },
                          ),
                          RoundedImage(
                            imageUrl: Images.promo2,
                            onPressed: () {
                              controller.navigateToFilteredMenu(context, 15000);
                            },
                          ),
                          RoundedImage(
                            imageUrl: Images.promo3,
                            onPressed: () {
                              controller.navigateToFilteredMenu(context, 20000);
                            },
                          ),
                        ],
                      ),
                    ),
                    Text("Favorite Makanan dan Minuman", style: LoginboldTextStyle),
                    SizedBox(height: 20),
                    if (controller.menuElement.length > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableCard(
                            width: screenWidth * 0.43,
                            height: screenHeight * 0.29,
                            context: context,
                            product: controller.menuElement[0],
                            isGuest: false,
                          ),
                          ReusableCard(
                            width: screenWidth * 0.43,
                            height: screenHeight * 0.29,
                            context: context,
                            product: controller.menuElement[1],
                            isGuest: false,
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
                    Text("Favorite Snack", style: LoginboldTextStyle),
                    SizedBox(height: 20),
                    Visibility(
                      visible: controller.menuElement.length > 1,
                      child: HomeSnack(),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
