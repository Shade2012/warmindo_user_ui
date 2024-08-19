import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/cart_page/controller/cart_controller.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/detailPopup_shimmer.dart';
import 'package:warmindo_user_ui/common/model/cart_model2.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/utils/themes/buttonstyle_themes.dart';
import '../../utils/themes/icon_themes.dart';
import '../counter/counterCart.dart';
import '../reusable_dialog.dart';
import 'myPopup_controller.dart';

class PopupDetail extends StatelessWidget {
  final MyCustomPopUpController popUpController = Get.put(MyCustomPopUpController());
  final CartController cartController = Get.find<CartController>();
  final MenuList menuList;

  PopupDetail({super.key, required this.menuList});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Observing the cart items filtered by menuId
    RxList<CartItem2> cartList = cartController.cartItems2
        .where((element) => element.productId == menuList.menuId)
        .toList()
        .obs;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 25, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.9,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                if (cartController.isLoading.value) {
                  // Shimmer effect while loading
                  return DetailPopupShimmer();
                } else {
                  cartList.value = cartController.cartItems2
                      .where((element) => element.productId == menuList.menuId)
                      .toList();

                  if (cartList.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Get.back();
                    });
                  }

                  // Actual content when loading is done
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(menuList.nameMenu, style: appBarTextStyle),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      Container(
                        width:double.infinity,
                        constraints: BoxConstraints(maxHeight: screenHeight * 0.7),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final cartItems = cartList[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text(cartItems.productName ?? '-', style: boldphoneNumberTextStyle),
                                        ),
                                        Visibility(
                                          visible: cartItems.selectedVarian != null,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Row(
                                              children: [
                                                Text('Varian: ', style: boldphoneNumberTextStyle),
                                                Text(cartItems.selectedVarian?.nameVarian ?? '-', style: subheaderverifyTextStyle),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: cartItems.selectedToppings!.isNotEmpty,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: SizedBox(
                                              width: screenWidth * 0.6,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: subheaderverifyTextStyle,
                                                  children: [
                                                    TextSpan(
                                                      text: 'Topping: ',
                                                      style: boldphoneNumberTextStyle,
                                                    ),
                                                    ...List.generate(cartItems.selectedToppings!.length, (index) {
                                                      final topping = cartItems.selectedToppings![index];
                                                      final isLast = index == cartItems.selectedToppings!.length - 1;
                                                      return TextSpan(
                                                        text: isLast ? topping.nameTopping : '${topping.nameTopping} + ',
                                                        style: subheaderverifyTextStyle,
                                                      );
                                                    }),
                                                  ],
                                                ),
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Obx(() {
                                      double totalPrice = 0;
                                      int toppingTotalPrice = 0;
                                      for (var topping in cartItems.selectedToppings!) {
                                        toppingTotalPrice += topping.priceTopping;
                                      }
                                      totalPrice += (cartItems.price + toppingTotalPrice) * cartItems.quantity.value;
                                      return Text(currencyFormat.format(totalPrice), style: boldTextStyle);
                                    })
                                  ],
                                ),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: () {
                                    popUpController.showCustomModalForItem(menuList, context, cartItems.quantity.value, cartid: cartItems.cartId?.value ?? 0);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: const Row(
                                          children: [
                                            Icon(Icons.edit, size: 17),
                                            SizedBox(width: 5),
                                            Text('Edit'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CounterWidget2(index: cartItems.cartId?.value ?? 0),
                                      const SizedBox(width: 10),
                                      InkWell(
                                          onTap: () {
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
                                                    cartController.removeItemFromCart(cartItems);
                                                    popUpController.isLoading.value = true;
                                                    Get.back();
                                                    Get.back();
                                                  },
                                                );
                                              },
                                            );

                                          },
                                          child: SvgPicture.asset(
                                            IconThemes.icon_trash,
                                            color: Colors.red,)),

                                    ],
                                  ),
                                ),

                              ],
                            );
                          },
                          itemCount: cartList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Divider(color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            popUpController.selectedVarian[cartList[0].cartId?.value ?? 0] = null;
                            popUpController.selectedToppings[cartList[0].cartId?.value ?? 0] = [];
                            popUpController.showCustomModalForItem(menuList, context, 1, cartid: 1);
                          },
                          style: redeembutton(),
                          child: Text('Tambah custom-an lain', style: whiteboldTextStyle15),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
