import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/myPopup_controller.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/home_page/controller/home_controller.dart';
import '../../pages/home_page/controller/schedule_controller.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../reusable_dialog.dart';

class CounterWidget extends StatelessWidget {
  final currencyFormat =
  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final MenuList menu;
  final RxInt quantity;
  final int cartId;
  final HomeController controller = Get.find<HomeController>();
  final cartController = Get.put(CartController());
  final menuController = Get.put(MenuPageController());
  final scheduleController = Get.find<ScheduleController>();
  final popupController = Get.find<MyCustomPopUpController>();

  CounterWidget(
      {super.key, required this.quantity, required this.menu, required this.cartId});

  int calculateTotalPrice() {
    int basePrice = menu.price;
    int itemQuantity = quantity.value;
    int toppingTotalPrice = 0;

    final selectedToppings = popupController.selectedToppings[cartId];
    if (selectedToppings != null) {
      for (var topping in selectedToppings) {
        toppingTotalPrice += topping.priceTopping;
      }
    }

    return (basePrice + toppingTotalPrice) * itemQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (quantity.value == 0) {
        return Text(
          'Kosong',
          style: boldTextStyle,
        );
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                int totalPrice = calculateTotalPrice();
                return Text(
                  currencyFormat.format(totalPrice),
                  style: onboardingHeaderTextStyle,
                );
              }),
              Row(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      if (quantity.value == 1) {
                        final currentCartId = cartController.getCartIdForFilter(cartId);
                        if (currentCartId != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ReusableDialog(
                                title: 'Pesan',
                                content:
                                'Apakah anda yakin untuk menghapus item ini dari keranjang?',
                                cancelText: "Tidak",
                                confirmText: "Iya",
                                onCancelPressed: () {
                                  Get.back();
                                },
                                onConfirmPressed: () async {
                                  cartController.removeItemFromCartWithID(
                                      currentCartId);
                                  quantity.value =
                                  0; // Directly update the value
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
                    child: const Center(
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${quantity.value}',
                    style: boldTextStyle,
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {
                      if(menu?.statusMenu == '0'){
                        if(Get.isSnackbarOpen != true) {
                          Get.snackbar('Pesan',
                              'Menu ini sedang dinonaktifkan');
                        }
                      }else{
                        if(quantity.value >= menu.stock!.value){
                          if(Get.isSnackbarOpen != true) {
                            Get.snackbar('Pesan', 'Maks ${menu.stock}');
                          }
                        }else{
                          quantity.value++;
                        }
                      }
                    },
                    backgroundColor: ColorResources.primaryColor,
                    mini: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              bool variantRequired = popupController.varianList.any((varian) => varian.category == menu.nameMenu);
              bool isCartItem = cartController.cartItems2.any((item) => item.cartId == cartId);
              if (scheduleController.jadwalElement[0].is_open) {
                if (variantRequired &&
                    popupController.selectedVarian[cartId] == null) {
                  if(Get.isSnackbarOpen != true) {
                    Get.snackbar('Pesan', 'Varian Harus dipilih');
                  }
                } else {
                  if (variantRequired) {
                    if (isCartItem) {
                      List<int> selectedToppingIds = popupController.selectedToppings[cartId]?.map((topping) => topping.toppingID).toList() ?? [];
                      final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.cartId == cartId);
                      final selectedVarianId = popupController.selectedVarian[cartId]?.varianID;
                      cartItem?.quantity.value = quantity.value;
                      cartController.cartItems2.refresh();
                      cartController.editCart(
                          idCart: cartId,
                          quantity: quantity.value,
                          menuID: menu.menuId,
                          variantId: selectedVarianId,
                          toppings: selectedToppingIds);
                      popupController.isLoading.value = true;
                      menuController.checkConnectivity();
                      popupController.isLoading.value = true;
                      Future.delayed(const Duration(seconds: 2), () {
                        popupController.isLoading.value = false;
                      });
                      Future.delayed(const Duration(seconds: 2), () {
                        controller.isLoading.value = false;
                      });
                      Get.back(closeOverlays: true);
                    }
                    else {
                      cartController.addToCart2(productId: menu.menuId, productName: menu.nameMenu, productImage: menu.image, price: menu.price, quantity: quantity.value, selectedVarian: popupController.selectedVarian[cartId], selectedToppings: popupController.selectedToppings[cartId], cartID: cartId);
                      cartController.cartItems2.refresh();
                      controller.isLoading.value = true;
                      Future.delayed(const Duration(seconds: 2), () {
                        controller.isLoading.value = false;
                      });
                      menuController.checkConnectivity();
                      Get.back(closeOverlays: true);
                    }
                  } else {
                    if (isCartItem) {
                      cartController.isLoading.value = true;
                      List<int> selectedToppingIds = popupController.selectedToppings[cartId]?.map((topping) => topping.toppingID).toList() ?? [];
                      final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.cartId == cartId);
                      cartItem?.quantity.value = quantity.value;
                      Get.back(closeOverlays: true);
                      await cartController.editCart(idCart: cartId, quantity: quantity.value, menuID: menu.menuId, toppings: selectedToppingIds);


                      cartController.fetchCart();
                      cartController.cartItems2.refresh();
                      menuController.checkConnectivity();
                      Future.delayed(const Duration(seconds: 2), () {
                        controller.isLoading.value = false;
                      });


                    } else {
                      cartController.addToCart2(productId: menu.menuId, productName: menu.nameMenu, productImage: menu.image, price: menu.price, quantity: quantity.value, selectedVarian: popupController.selectedVarian[cartId], selectedToppings: popupController.selectedToppings[cartId], cartID: cartId);
                      cartController.cartItems2.refresh();
                      controller.isLoading.value = true;
                      Future.delayed(const Duration(seconds: 2), () {
                        controller.isLoading.value = false;
                      });

                      menuController.checkConnectivity();
                      Get.back(closeOverlays: true);
                    }
                  }
                }
              } else {
                if(Get.isSnackbarOpen != true) {
                  Get.snackbar('Pesan',
                      'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti',
                      colorText: Colors.black);
                }
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                color: ColorResources.btnonboard,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 14,
              child: Center(
                child: Text(
                  cartController.getCartIdForFilter(cartId) == null
                      ? "Tambahkan ke Keranjang"
                      : "Perbarui Keranjang",
                  style: whiteboldTextStyle,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
