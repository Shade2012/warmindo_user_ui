import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/pages/testing.dart';
import 'package:warmindo_user_ui/widget/reusable_dialog.dart';
import '../pages/cart_page/controller/cart_controller.dart';
import '../common/model/cartmodel.dart';
import '../pages/home_page/controller/schedule_controller.dart';
import '../routes/AppPages.dart';
import 'myCustomPopUp/myCustomPopup.dart';
import 'myCustomPopUp/myPopup_controller.dart';

class Cart extends StatelessWidget {
  final scheduleController = Get.find<ScheduleController>();
  final cartController = Get.put(CartController());
  final popUpcontroller = Get.put(MyCustomPopUpController());

  final BuildContext context;
  final MenuList product;

  Cart({required this.context, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.productId == product.menuId);
          final menuQuantity = cartItem?.quantity.value ?? 0;

          if (scheduleController.jadwalElement[0].is_open == false) {
            Get.snackbar('Pesan', 'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti', colorText: Colors.black);
          } else {
            if (cartItem == null) {
              if (cartController.userPhone.value.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ReusableDialog(
                      title: 'Pesan',
                      content: 'Nomor telepon Anda belum tersimpan. Silakan masukkan nomor WA anda yang aktif untuk melanjutkan',
                      cancelText: 'Nanti',
                      confirmText: 'Oke',
                      onCancelPressed: () => Get.back(),
                      onConfirmPressed: () => Get.toNamed(Routes.EDITPROFILE_PAGE),
                    );
                  },
                );
              }
              else if (cartController.userPhoneVerified.value.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ReusableDialog(
                      title: 'Pesan',
                      content: 'Nomor telepon anda belum terverifikasi, verifikasi terlebih dahulu untuk melanjutkan',
                      cancelText: 'Nanti',
                      confirmText: 'Oke',
                      onCancelPressed: () => Get.back(),
                      onConfirmPressed: () => cartController.goToVerification(),
                    );
                  },
                );
              }
              else {
                // popUpcontroller.fetchTopping();
                // popUpcontroller.fetchVarian();

                bool variantRequired = popUpcontroller.varianList.any((varian) => varian.category == product.nameMenu);
                if(variantRequired){
                  popUpcontroller.showCustomModalForItem(product, context, 1, cartid: 0);
                } else {
                  popUpcontroller.addToCart2(product: product, quantity: 1);
                  popUpcontroller.showCustomModalForItem(product, context, 1, cartid: 0); // Show with initial quantity 1
                }
              }
            } else {
              // popUpcontroller.fetchTopping();
              // popUpcontroller.fetchVarian();
              popUpcontroller.showCustomModalForItem(product, context, menuQuantity, cartid: cartItem.cartId ?? 0);
            }
          }

          print('Cart Items: ${cartController.cartItems}');
        } catch (e) {
          print('Error: $e');
          Get.snackbar('Error', 'An error occurred', colorText: Colors.white, backgroundColor: Colors.red);
        }
      },

      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Color.fromARGB(160, 0, 0, 0),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}


