import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/myPopup_controller.dart';

import '../../../common/model/cart_model2.dart';
import '../../../common/model/cartmodel.dart';
import '../../../routes/AppPages.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/icon_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/counter/counterCart.dart';

import '../../home_page/controller/schedule_controller.dart';
import '../controller/cart_controller.dart';
import 'package:get/get.dart';
class CartData extends StatelessWidget {
  final scheduleController = Get.find<ScheduleController>();
  final CartController controller = Get.put(CartController());
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());

   CartData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            height: screenHeight * 0.58,
            child: ListView.builder(
              shrinkWrap: true, // Add this line
              // Add this line
              itemCount: controller.cartItems2.length,
              itemBuilder: (BuildContext context, int index) {
                final cartItem = controller.cartItems2[index];
                int toppingTotalPrice = 0;

                if (cartItem.selectedToppings != null) {
                  for (var topping in cartItem.selectedToppings!) {
                    toppingTotalPrice += topping.priceTopping;
                  }
                }
                final totalItemPrice = (cartItem.price + toppingTotalPrice) * cartItem.quantity.value;
                print(cartItem);
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth / 3.4,
                        height: screenWidth / 3.4,
                        child: ClipRRect(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                          child: Image.network(cartItem.productImage, fit: BoxFit.cover,),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child:
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartItem.productName,
                                      style: boldTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            final product = controller.menuController.menuElement.firstWhere((element) => element.menuId == cartItem.productId);
                                            popUpController.showCustomModalForItem(product, context, cartItem.quantity.value, cartid: cartItem.cartId ?? 0);
                                            // controller.isLoading.value = true;
                                            },
                                          child: Icon(Icons.edit,size: 30,color: Colors.orange,)),
                                      InkWell(
                                          onTap: () {
                                            controller.removeItemFromCart(cartItem);
                                            controller.isLoading.value = true;
                                            },
                                          child: SvgPicture.asset(
                                            IconThemes.icon_trash,
                                            color: Colors.red,)),
                                    ],
                                  )
                                ],
                              ),
                              Visibility(
                                visible: cartItem.selectedVarian?.nameVarian != null,
                                child: Container(
                                    child: Text(cartItem.selectedVarian?.nameVarian ?? "")),
                              ),
                              Visibility(
                                visible: cartItem.selectedToppings != null && cartItem.selectedToppings!.isNotEmpty,
                                child: Container(

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Text.rich(
                                      TextSpan(
                                        children: List.generate(cartItem.selectedToppings!.length, (index) {
                                          final topping = cartItem.selectedToppings![index];
                                          final isLast = index == cartItem.selectedToppings!.length - 1;
                                          return TextSpan(
                                            text: isLast ? topping.nameTopping : '${topping.nameTopping} + ',
                                            style: TextStyle(overflow: TextOverflow.ellipsis),
                                          );
                                        }),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.046,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currencyFormat.format(totalItemPrice),
                                    style: boldTextStyle,
                                  ),
                                  CounterWidget2(index: index),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Obx(() {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total", style: boldTextStyle),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    '(${controller.cartItems2.length} Items)'),
                                SizedBox(
                                  width: 5,
                                ),
                                Obx(() {
                                  double totalPrice = 0;

                                  for (CartItem2 cartItem in controller.cartItems2) {
                                    int toppingTotalPrice = 0;
                                    if (cartItem.selectedToppings != null) {
                                      for (var topping in cartItem.selectedToppings!) {
                                        toppingTotalPrice += topping.priceTopping;
                                      }
                                    }
                                    totalPrice += (cartItem.price + toppingTotalPrice) * cartItem.quantity.value;
                                  }

                                  return Text(
                                    currencyFormat.format(totalPrice),
                                    style: boldTextStyle,
                                  );
                                }),
                              ]),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      //Voucher Price
                      SizedBox(height: 10),
                    ],
                  );
                }),
                InkWell(
                  onTap: (){
                    if(scheduleController.jadwalElement[0].is_open == false){
                      Get.snackbar('Pesan', 'Maaf Toko saat ini sedang tutup silahkan coba lagi nanti',colorText: Colors.black);
                    }else{
                      Get.toNamed(Routes.PEMBAYARAN_PAGE);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Bayar",
                      style: whitevoucherTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
