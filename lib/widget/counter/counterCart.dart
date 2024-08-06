
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../pages/cart_page/controller/cart_controller.dart';
import '../../common/model/cartmodel.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/textstyle_themes.dart';


class CounterWidget2 extends StatelessWidget {
  final cartController = Get.put(CartController());
  int index;
  CounterWidget2({required this.index });
  @override
  Widget build(BuildContext context) {
    final cartItem = cartController.cartItems2[index];
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
    cartController.decrementQuantity(cartItem);
    cartController.isLoading.value = true;
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
          Text(
            '${cartItem.quantity}',
            style: boldTextStyle,
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
                  cartController.incrementQuantity(cartItem);
                  cartController.isLoading.value = true;
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
