import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/myPopup_controller.dart';

import '../../common/model/cartmodel.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/home_page/controller/schedule_controller.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../reusable_dialog.dart';

class CounterWidget extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final MenuList menu;
  final RxInt quantity;
  final int cartId;
  final cartController = Get.put(CartController());
  final menuController = Get.put(MenuPageController());
  final scheduleController = Get.find<ScheduleController>();
  final popupController = Get.find<MyCustomPopUpController>();

  CounterWidget({required this.quantity, required this.menu, required this.cartId});

  int calculateTotalPrice() {
    int basePrice = menu.price;
    int itemQuantity = quantity.value;
    int toppingTotalPrice = 0;

    final selectedToppings = popupController.selectedToppings[menu.menuId];
    if (selectedToppings != null) {
      for (var topping in selectedToppings) {
        toppingTotalPrice += topping.priceTopping;
      }
    }

    return (basePrice + toppingTotalPrice) * itemQuantity;
  }

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
                Obx(() {
                  // Calculate the total price every time the quantity or selectedToppings change
                  int totalPrice = calculateTotalPrice();
                  return Container(
                    child: Text(
                      currencyFormat.format(totalPrice),
                      style: onboardingHeaderTextStyle,
                    ),
                  );
                }),
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        if (quantity.value == 1) {
                          final currentCartId = cartController.getCartIdForMenu(menu.menuId);
                          if (currentCartId != null) {
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
                                    cartController.removeItemFromCartWithID(currentCartId);
                                    quantity.value = 0; // Directly update the value
                                    menuController.checkConnectivity();
                                    Get.back();
                                    Get.back();
                                  },
                                );
                              },
                            );
                          } else {
                            return;
                          }
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
                    SizedBox(width: 16),
                    Text(
                      '${quantity.value}',
                      style: boldTextStyle,
                    ),
                    SizedBox(width: 20),
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
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                bool variantRequired = popupController.varianList.any((varian) => varian.category == menu.nameMenu);
                bool isCartItem = cartController.cartItems2.any((item) => item.productId == menu.menuId);
                final currentCartId = cartController.getCartIdForMenu(menu.menuId);
                if (scheduleController.jadwalElement[0].is_open) {
                  if (variantRequired && popupController.selectedVarian[menu.menuId] == null) {
                    Get.snackbar('Pesan', 'Varian Harus dipilih');
                  } else {
                    if (variantRequired) {
                      if (isCartItem) {
                        List<int> selectedToppingIds = popupController.selectedToppings[menu.menuId]?.map((topping) => topping.toppingID).toList() ?? [];
                        final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.productId == menu.menuId);
                        final selectedVarianId = popupController.selectedVarian[menu.menuId]?.varianID;

                        cartController.editCart(idCart: cartId, quantity: quantity.value, menuID: menu.menuId, variantId: selectedVarianId,toppings: selectedToppingIds);
                        cartItem?.quantity.value = quantity.value;
                        menuController.checkConnectivity();
                        Get.back();
                      } else {
                        print('di counter ${popupController.selectedToppings[menu.menuId]}');
                        print('di counter ${popupController.selectedVarian[menu.menuId]}');
                        cartController.addToCart2(
                          productId: menu.menuId,
                          productName: menu.nameMenu,
                          productImage: menu.image,
                          price: menu.price,
                          quantity: quantity.value,
                          selectedVarian: popupController.selectedVarian[menu.menuId],
                          selectedToppings: popupController.selectedToppings[menu.menuId]
                        );
                        menuController.checkConnectivity();
                        Get.back();
                      }
                    } else {
                      List<int> selectedToppingIds = popupController.selectedToppings[menu.menuId]?.map((topping) => topping.toppingID).toList() ?? [];
                      final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.productId == menu.menuId);
                      cartController.editCart(idCart: cartItem?.cartId ?? 0, quantity: quantity.value, menuID: menu.menuId, toppings: selectedToppingIds);
                      cartItem?.quantity.value = quantity.value;
                      menuController.checkConnectivity();
                      Get.back();
                    }
                  }
                } else {
                  Get.snackbar('Pesan', 'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti', colorText: Colors.black);
                }
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
                    cartController.getCartIdForMenu(menu.menuId) == null ? "Tambahkan ke Keranjang" : "Perbarui Keranjang",
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


