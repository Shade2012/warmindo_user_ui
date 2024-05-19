import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/pages/cart_page/model/cartmodel.dart';
import 'package:warmindo_user_ui/pages/voucher_page/controller/voucher_controller.dart';
import 'package:warmindo_user_ui/widget/counter/counterCart.dart';

import '../../../routes/AppPages.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/icon_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';

class CartPage extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  final VoucherController voucherController = Get.put(VoucherController());
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppbarCustom(title: 'Keranjang',style: headerRegularStyle,),
      body: Container(
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
          if (controller.cartItems.isEmpty) {
            return Center(
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
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cartItem = controller.cartItems[index];
                      final totalItemPrice = cartItem.price * cartItem.quantity;
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: screenWidth / 3.4,
                              height: screenWidth / 3.4,
                              child: ClipRRect(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(cartItem.productImage, fit: BoxFit.cover,),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cartItem.productName,
                                          style: boldTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {controller.removeItemFromCart(index);},
                                          child: SvgPicture.asset(
                                            IconThemes.icon_trash,
                                            color: Colors.red,))
                                    ],
                                  ),
                                  SizedBox(height: screenHeight / 15,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        currencyFormat.format(totalItemPrice),
                                        style: boldTextStyle,
                                      ),
                                      CounterWidget2(index: index),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Voucher", style: boldgreyText,),
                          Container(
                            child: voucherController.appliedVoucher.value != null ?
                            Container(height: 50, width: 120, child: Image.asset(voucherController.appliedVoucher.value!.imagePath, fit: BoxFit.cover,)) : Text("Pilih Voucher"),
                          ),
                          InkWell(
                            onTap: () {voucherController.showVoucher(context);},
                            child: Container(
                                decoration: BoxDecoration(
                                    color: ColorResources.btnonboard2,
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                padding: EdgeInsets.all(10),
                                child: Text(voucherController.appliedVoucher.value != null ? "Ganti" : "Pakai",
                                  style: verifyStatusTextStyle,
                                )),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Obx(() {
                        if (voucherController.appliedVoucher.value != null) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Subtotal", style: boldTextStyle),
                                  Obx(() {
                                    double totalPrice = 0;
                                    for (CartItem cartItem
                                    in controller.cartItems) {
                                      totalPrice +=
                                          cartItem.price * cartItem.quantity;
                                    }
                                    return Text(
                                        currencyFormat.format(totalPrice),
                                        style: boldTextStyle);
                                  }),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Voucher", style: boldTextStyle),
                                  Obx(() {
                                    return Text("- " + currencyFormat.format(voucherController.appliedVoucher.value!.discount).toString(), style: boldTextStyle,
                                    );
                                  }),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total", style: boldTextStyle),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            '(${controller.cartItems.length} Items)'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Obx(() {
                                          double totalPrice = 0;
                                          for (CartItem cartItem in controller.cartItems) {
                                            totalPrice += cartItem.price * cartItem.quantity;
                                            totalPrice -= voucherController.appliedVoucher.value?.discount ?? 0;
                                          }
                                          return Text(
                                              currencyFormat.format(totalPrice),
                                              style: boldTextStyle);
                                        }),
                                      ]),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              //Voucher Price
                              SizedBox(height: 10),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Subtotal", style: boldTextStyle),
                                  Obx(() {
                                    double totalPrice = 0;
                                    for (CartItem cartItem
                                    in controller.cartItems) {
                                      totalPrice +=
                                          cartItem.price * cartItem.quantity;
                                    }
                                    return Text(
                                        currencyFormat.format(totalPrice),
                                        style: boldTextStyle);
                                  }),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total", style: boldTextStyle),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            '(${controller.cartItems.length} Items)'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Obx(() {
                                          double totalPrice = 0;
                                          for (CartItem cartItem
                                          in controller.cartItems) {
                                            totalPrice += cartItem.price *
                                                cartItem.quantity;
                                          }
                                          return Text(
                                              currencyFormat.format(totalPrice),
                                              style: boldTextStyle);
                                        }),
                                      ]),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              //Voucher Price
                              SizedBox(height: 10),
                            ],
                          );
                        }
                      }),
                      InkWell(
                        onTap: (){
                          Get.toNamed(Routes.PEMBAYARAN_PAGE);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Bayar",
                            style: whitevoucherTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
