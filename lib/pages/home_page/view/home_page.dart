
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/home_page/controller/home_controller.dart';
import 'package:warmindo_user_ui/pages/home_page/shimmer/homeshimmer.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';
import 'package:warmindo_user_ui/widget/cart.dart';
import 'package:warmindo_user_ui/widget/makanan_widget.dart';
import 'package:warmindo_user_ui/widget/reusable_card.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/minuman_widget.dart';
import '../../../widget/rounded_image.dart';
import '../../../widget/snack_widget.dart';
import '../../detail-menu_page/view/detail_menu_page.dart';

class HomePage extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Obx(() => controller.isLoading.value?
            HomeSkeleton() :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Selamat Pagi", style: regularTextStyle),
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Text("User", style: boldTextStyle2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MakananWidget(),
                    MinumanWidget(),
                    SnackWidget(),
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
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableCard(width: screenWidth * 0.43,context: context, product: controller.menu[0], isGuest: false, ),
                    ReusableCard(width: screenWidth * 0.43 ,context: context, product: controller.menu[1],isGuest: false,),

                  ],
                ),
                SizedBox(height: 20,),
                Text("Favorite Snack", style: LoginboldTextStyle),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.to(DetailMenuPage(menu: controller.menu[11], isGuest: false,));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: ColorResources.backgroundCardColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text(controller.menu[11].name, style: regularInputTextStyle),
                              SizedBox(height: 3,),
                              Text(
                                controller.menu[11].description,
                                style: descriptionTextStyle,
                              ),
                              SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Icon(Icons.star_rounded, color: Colors.orange, size: 20,),
                                      Text(controller.menu[11].ratings.first.toString(), style: ratingTextStyle),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(currencyFormat.format(controller.menu[11].price), style: priceTextStyle),
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Stack(
                          children: [
                            Container(
                              width: 122, // Use the screen width
                              height: 104,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: (Radius.circular(20)),
                                  bottomRight: (Radius.circular(20)),
                                ),
                                child: FadeInImage(
                                  image: AssetImage(Images.onboard1),
                                  fit: BoxFit.cover,
                                  placeholder: AssetImage(Images.onboard2),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 8,
                              child: Container(
                                child: GestureDetector(
                                  onTap: (){},
                                  child: Cart(context: context, product: controller.menu[11],),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}
