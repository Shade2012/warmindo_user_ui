import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/common/model/cartmodel.dart';
import 'package:warmindo_user_ui/pages/cart_page/shimmer/cart_shimmer.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_data.dart';

import 'package:warmindo_user_ui/widget/counter/counterCart.dart';

import '../../../routes/AppPages.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/icon_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';

class CartPage extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppbarCustom(title: 'Keranjang',style: headerRegularStyle,),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchCart();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),// Wrap with SingleChildScrollView
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              color: ColorResources.backgroundCardColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: EdgeInsets.all(20),
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
              }else if(controller.cartItems.isEmpty) {
                return Center(
                  child: Container(
                    height: screenHeight * 0.75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: screenWidth / 4,
                            child: Image.asset(
                              Images.cart,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Keranjang mu kosong,yuk beli",
                          style: onboardingskip,
                        )
                      ],
                    ),
                  ),
                );
              } else {
                if(controller.isLoading == true){
                  return CartShimmer();
                }else{
                  return Column(
                    children: [
                      CartData(),
                    ],
                  );
                }
              }
            }),
          ),
        ),
      ),
    );
  }
}
