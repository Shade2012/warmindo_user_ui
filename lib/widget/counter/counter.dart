
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';


import '../../common/model/cartmodel.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../reusable_dialog.dart';


class CounterWidget extends StatelessWidget {
  final CartItem cartItem;
  final cartController = Get.find<CartController>();

  CounterWidget({required this.cartItem});
  @override
  Widget build(BuildContext context) {
    int cartItemIndex = cartController.cartItems.indexWhere((item) => item.productId == cartItem.productId);

    return Container(
      child: Obx(() {
        if(cartItemIndex >= cartController.cartItems.length){
          return Container(
            child: Text(
              'Kosong',
              style: boldTextStyle,
            ),
          );
        }
        return Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                if(cartController.cartItems[cartItemIndex].quantity == 1){
                  showDialog(context: context, builder: (BuildContext context){
                    return ReusableDialog(
                      title: 'Pesan',
                      content: 'Apakah anda yakin untuk menghapus item ini dari keranjang?',
                      cancelText: "Tidak",
                      confirmText: "Iya",
                      onCancelPressed: () {
                        cartController.cartItems[cartItemIndex].quantity = 1.obs;
                        Get.back();
                      },
                      onConfirmPressed: () {
                        cartController.cartItems[cartItemIndex].quantity = 0.obs;
                        cartController.removeItemFromCart(cartController.cartItems[cartItemIndex]);
                        Get.back();
                        Get.back();
                      },
                    );
                  });
                }else{
                  cartController.decrementQuantityPopup(cartItemIndex);
                }
                print(cartItem.quantity);
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
                  '${cartController.cartItems[cartItemIndex].quantity}',
                  style: boldTextStyle,
                ),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              onPressed: () {
                cartController.incrementQuantityPopup(cartItemIndex);
                print(cartItem.quantity);
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
        );
      }),
    );
  }
}
