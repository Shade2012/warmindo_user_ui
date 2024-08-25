import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/home_controller.dart';
import 'package:warmindo_user_ui/pages/home_page/shimmer/homeshimmer.dart';
import 'package:warmindo_user_ui/pages/home_page/view/home_snack.dart';
import 'package:warmindo_user_ui/pages/home_page/widget/home_status.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/myPopup_controller.dart';
import 'package:warmindo_user_ui/widget/makanan_widget.dart';
import 'package:warmindo_user_ui/widget/reusable_card.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/minuman_widget.dart';
import '../../../widget/rounded_image.dart';
import '../../../widget/snack_widget.dart';
import '../../cart_page/controller/cart_controller.dart';


class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());

   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.isLoading.value = true;
            await controller.scheduleController.fetchSchedule();
            cartController.fetchCart();
            await popUpController.fetchVarian();
            await popUpController.fetchTopping();
            await controller.fetchname();
            await controller.fetchProduct();

            // controller.scheduleController.jadwalElement.clear();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),// Wrap with SingleChildScrollView
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                  return const HomeSkeleton();
                }
                if(controller.scheduleController.jadwalElement.isEmpty){
                  return SizedBox(
                      height: screenHeight * 0.7 ,child: Center(child: Text('Server sedang sibuk, silahkan reload',style: boldTextStyle,),));
                }
                return Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Selamat Pagi", style: regularTextStyle),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
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
                    const SizedBox(height: 20),
                    if (controller.menuElement.where((element) => element.category == 'Minuman').length > 0 && controller.menuElement.where((element) => element.category == 'Makanan').length > 0 )
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableCard(
                            width: screenWidth * 0.43,
                            height: screenHeight * 0.29,
                            context: context,
                            product: controller.getHighestRatingMenu(controller.menuElement,1),
                            isGuest: false,
                          ),
                          ReusableCard(
                            width: screenWidth * 0.43,
                            height: screenHeight * 0.29,
                            context: context,
                            product: controller.getHighestRatingMenu(controller.menuElement,2),
                            isGuest: false,
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Text("Favorite Snack", style: LoginboldTextStyle),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: controller.menuElement.where((element) => element.category == 'Snack').length > 0,
                      child: HomeSnack(menuItem: controller.getHighestRatingMenu(controller.menuElement,3),),
                    ),
                    const SizedBox(height: 20),
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
