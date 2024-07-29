import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

import '../../common/model/cartmodel.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../reusable_dialog.dart';

class CounterWidget extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final MenuList menu;
  late final RxInt quantity;
  late final int cartId;
  final cartController = Get.put(CartController());
  final menuController = Get.put(MenuPageController());

  CounterWidget({required this.quantity, required this.menu, required this.cartId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        if (quantity.value == 0) {
          return Container(
            child: Text(
              'Kosong',
              style: boldTextStyle,
            ),
          );
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                      () => Container(
                    child: Text(
                      (currencyFormat.format(quantity.value * menu.price)),
                      style: onboardingHeaderTextStyle,
                    ),
                  ),
                ),
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        if (quantity.value == 1) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ReusableDialog(
                                title: 'Pesan',
                                content: 'Apakah anda yakin untuk menghapus item ini dari keranjang?',
                                cancelText: "Tidak",
                                confirmText: "Iya",
                                onCancelPressed: () {
                                  Get.back();
                                },
                                onConfirmPressed: () async {
                                  // Remove from cart
                                  cartController.removeItemFromCartWithID(cartId);
                                  quantity.value = 0; // Directly update the value
                                 menuController.checkConnectivity();
                                  Get.back();
                                  Get.back();
                                },
                              );
                            },
                          );
                        } else {
                          quantity.value--;
                        }
                      },
                      backgroundColor: ColorResources.primaryColor,
                      mini: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      '${quantity.value}',
                      style: boldTextStyle,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        quantity.value++;
                      },
                      backgroundColor: ColorResources.primaryColor,
                      mini: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                final cartItem = cartController.cartItems.firstWhereOrNull((item) => item.productId == menu.menuId);
                cartController.editCart(idCart: cartId, quantity: quantity.value);
                cartItem?.quantity.value = quantity.value;
                menuController.checkConnectivity();
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorResources.btnonboard,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 14,
                child: Center(
                  child: Text(
                    "Perbarui Keranjang",
                    style: whiteboldTextStyle,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
