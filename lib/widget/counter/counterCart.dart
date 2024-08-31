import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/model/menu_list_API_model.dart';
import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/menu_page/controller/menu_controller.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../myCustomPopUp/myPopup_controller.dart';


class CounterWidget2 extends StatelessWidget {
  final MenuPageController menuController = Get.put(MenuPageController());
  final popupController = Get.find<MyCustomPopUpController>();
  final cartController = Get.put(CartController());
  int index;
  CounterWidget2({super.key, required this.index });
  @override
  Widget build(BuildContext context) {
    final cartItem = cartController.cartItems2.firstWhere((element) => element.cartId == index);
    return Row(
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
                Future.delayed(const Duration(seconds: 2), () {
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
            child: const Icon(
              Icons.remove,
              color: Colors.black,size: 20,
            ),
          )
        ),
        const SizedBox(
          width: 15,
        ),
        Obx(()
          => Text(
            '${cartItem.quantity.value}',
            style: boldTextStyle,
          ),
        ),

        const SizedBox(
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
                final menu = menuController.menuElement.firstWhere((element) => element.menuId == cartItem.productId, orElse: () => MenuList(
                  menuId: 0,
                  nameMenu: '',
                  image: '',
                  stock: 0,
                  price: 0,
                  category: '',
                  statusMenu: '0',
                  description: '',
                )); // Default object);
                if(menu?.statusMenu == '0'){
                  Get.snackbar('Pesan', 'Menu ini sedang dinonaktifkan');
                }else{
                  if(menu!.stock! <= cartItem.quantity.value){
                    Get.snackbar('Pesan', 'Maks ${menu.stock}');
                  }else{
                    cartController.isLoading.value = true;
                    cartController.incrementQuantity(cartItem);
                    cartController.cartItems2.refresh();
                  }
                }

              },
              child: const Icon(
                Icons.add,
                color: Colors.white,size: 20,
              ),
            )
        ),
      ],
    );
  }
}
