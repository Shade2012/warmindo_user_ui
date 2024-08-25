import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/cart_page/shimmer/cart_shimmer.dart';
import 'package:warmindo_user_ui/pages/cart_page/view/cart_data.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/myCustomPopUp/myPopup_controller.dart';

class CartPage extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Keranjang',style: headerRegularStyle,),centerTitle: true,automaticallyImplyLeading: false,),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.isLoading.value = true;
          await controller.menuController.fetchProduct();
          await controller.fetchCart();
          print('ini token:${controller.token.value}');
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),// Wrap with SingleChildScrollView
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              color: ColorResources.backgroundCardColor,
              borderRadius:const BorderRadius.all(Radius.circular(20)),
            ),
            margin: const EdgeInsets.all(20),
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
              }else if(controller.cartItems2.isEmpty) {
                return Center(
                  child: SizedBox(
                    height: screenHeight * 0.75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: screenWidth / 4,
                            child: Image.asset(
                              Images.cart,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
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
                if(controller.isLoading.value == true){
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
