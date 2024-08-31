import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/widget/reusable_dialog.dart';
import '../pages/cart_page/controller/cart_controller.dart';
import '../pages/home_page/controller/schedule_controller.dart';
import '../routes/AppPages.dart';
import 'myCustomPopUp/myPopup_controller.dart';

class Cart extends StatelessWidget {
  final scheduleController = Get.find<ScheduleController>();
  final cartController = Get.put(CartController());
  final popUpcontroller = Get.put(MyCustomPopUpController());

  final BuildContext context;
  final MenuList product;

  Cart({super.key, required this.context, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final cartItem = cartController.cartItems2.firstWhereOrNull((item) => item.productId == product.menuId);
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
                popUpcontroller.fetchVarian();
                if(product.statusMenu == '1'){
                  if(product.stock! < 1 ){
                    Get.snackbar('Pesan', 'Stok Menu Habis ');
                  }else{
                    bool variantRequired = popUpcontroller.varianList.any((varian) => varian.category == product.nameMenu);
                    if(variantRequired){
                      popUpcontroller.showCustomModalForItem(product, context, 1, cartid: -1);
                    }
                    else {
                       popUpcontroller.addToCart2(product: product, quantity: 1, cartID: cartItem?.cartId?.value ?? 0, context: context,);
                      final cartItem2 = cartController.cartItems2.firstWhereOrNull((item) => item.productId == product.menuId);
                      popUpcontroller.showCustomModalForItem(product, context, 1, cartid: cartItem2?.cartId?.value ?? 0);
                    }
                  }
                }else{
                  Get.snackbar('Pesan', 'Menu ini sedang dinonaktifkan.');
                }
              }
            } else {
              if(product.statusMenu == '1'){
                if(product.stock! < 1 ){
                  Get.snackbar('Pesan', 'Stok Menu Habis ');
                }else{
                  popUpcontroller.showDetailPopupModal(context, product);
                }
              }else{
                Get.snackbar('Pesan', 'Menu ini sedang dinonaktifkan.');
              }

            }
          }
        } catch (e) {
          print('Error: $e');
          Get.snackbar('Error', 'An error occurred', colorText: Colors.white, backgroundColor: Colors.red);
        }
      },

      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: const Color.fromARGB(160, 0, 0, 0),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}


