import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/controller/guest_home_controller.dart';
import 'package:warmindo_user_ui/pages/guest_home_page/view/guest_snack.dart';
import 'package:warmindo_user_ui/widget/makanan_widget.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/minuman_widget.dart';
import '../../../widget/myCustomPopUp/myPopup_controller.dart';
import '../../../widget/reusable_card.dart';
import '../../../widget/rounded_image.dart';
import '../../../widget/snack_widget.dart';
import '../../home_page/shimmer/homeshimmer.dart';
import '../../home_page/widget/home_status.dart';

class GuestHomePage extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final GuestHomeController controller = Get.put(GuestHomeController());
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());

  GuestHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.scheduleController.fetchSchedule(true);
            await popUpController.fetchVarian();
            await popUpController.fetchTopping();
            await controller.fetchProduct();
          },
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Obx((){
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
                if(controller.isLoading.value){
                  return const HomeSkeleton();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text("Selamat Pagi", style: regularTextStyle),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Text("Guest", style: boldTextStyle2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    MakananWidget(true),
                    MinumanWidget(true),
                    SnackWidget(true),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    HomeStatus(),
                    const SizedBox(height: 20,),
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
                    const SizedBox(height: 20,),
                    if (controller.menuElement.where((element) => element.category == 'Minuman').length > 0 && controller.menuElement.where((element) => element.category == 'Makanan').length > 0 )
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableCard(width: screenWidth * 0.43,height: screenHeight * 0.29, context: context, product: controller.getHighestRatingMenu(controller.menuElement,1),isGuest: true,),
                        ReusableCard(width: screenWidth * 0.43,height: screenHeight * 0.29,context: context, product:controller.getHighestRatingMenu(controller.menuElement,2),isGuest: true,),

                      ],
                    ),
                    // const SizedBox(height: 20,),
                    // Text("Favorite Snack", style: LoginboldTextStyle),
                    // const SizedBox(height: 20,),
                    // Visibility(
                    //     visible: controller.menuElement.where((element) => element.category == 'Snack').length > 0,
                    //     child: GuestSnack(menuItem: controller.getHighestRatingMenu(controller.menuElement,3))),
                    const SizedBox(height: 20,)
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
