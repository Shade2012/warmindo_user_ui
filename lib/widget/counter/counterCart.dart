
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../pages/cart_page/controller/cart_controller.dart';
import '../../pages/cart_page/model/cartmodel.dart';
import '../../utils/themes/color_themes.dart';
import '../../utils/themes/textstyle_themes.dart';


class CounterWidget2 extends StatelessWidget {
  final cartController = Get.put(CartController());
  int index;
  CounterWidget2({required this.index });
  @override
  Widget build(BuildContext context) {
    final cartItem = cartController.cartItems[index];
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
    cartController.decrementQuantity(index);
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
                  cartController.incrementQuantity(index);
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
