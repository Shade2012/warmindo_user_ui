
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../pages/cart_page/controller/cart_controller.dart';
import '../../common/model/cartmodel.dart';
import '../../pages/menu_page/controller/menu_controller.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../myCustomPopUp/myPopup_controller.dart';


class CounterWidget2 extends StatelessWidget {
  final MenuPageController menuController = Get.put(MenuPageController());
  final popupController = Get.find<MyCustomPopUpController>();
  final cartController = Get.put(CartController());
  int index;
  CounterWidget2({required this.index });
  @override
  Widget build(BuildContext context) {
    final cartItem = cartController.cartItems2.firstWhere((element) => element.cartId == index);
    print(cartItem.productName);
    return  Container(
      child:  Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black, // Border color
                width: 2, // Border width
              ),
            ),
            child: GestureDetector(
              onTap: (){
                if(cartItem.quantity.value == 0){
                  cartController.decrementQuantity(cartItem);
                  cartController.cartItems2.refresh();
                  cartController.isLoading.value = true;
                  popupController.isLoading.value = true;
                  Future.delayed(Duration(seconds: 2), () {
                    popupController.isLoading.value = false;
                  });
                }else{
                  menuController.isLoading.value = true;
                  cartController.isLoading.value = true;
                  cartController.decrementQuantity(cartItem);
                  menuController.isLoading.value = false;
                  cartController.cartItems2.refresh();
                }
    },
              child: Icon(
                Icons.remove,
                color: Colors.black,size: 20,
              ),
            )
          ),
          SizedBox(
            width: 15,
          ),
          Obx(()
            => Text(
              '${cartItem.quantity.value}',
              style: boldTextStyle,
            ),
          ),

          SizedBox(
            width: 15,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2, // Border width
                ),
              ),
              child: GestureDetector(
                onTap: (){
                  cartController.isLoading.value = true;
                  cartController.incrementQuantity(cartItem);
                  cartController.cartItems2.refresh();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,size: 20,
                ),
              )
          ),
        ],
      ),
    );
  }
}
