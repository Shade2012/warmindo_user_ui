
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/common/model/menu_list_API_model.dart';
import 'package:warmindo_user_ui/common/model/varians.dart';
import 'package:warmindo_user_ui/widget/myCustomPopUp/myPopup_controller.dart';

import '../../../common/model/cart_model2.dart';
import '../../../common/model/toppings.dart';
import '../../../routes/AppPages.dart';
import '../../../utils/themes/icon_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/counter/counterCart.dart';

import '../../home_page/controller/schedule_controller.dart';
import '../controller/cart_controller.dart';
import 'package:get/get.dart';
class CartData extends GetView<CartController> {
  final scheduleController = Get.find<ScheduleController>();
  final popUpController = Get.find<MyCustomPopUpController>();

   CartData({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [

        Obx((){
          return Container(
            padding: const EdgeInsets.only(top: 10),
            height: screenHeight * 0.58,
            child: ListView.builder(
              shrinkWrap: true, // Add this line
              // Add this line
              itemCount: controller.cartItems2.length,
              itemBuilder: (BuildContext context, int index) {
                final cartItem = controller.cartItems2[index];
                final menu = controller.menuController.menuElement.firstWhere(
                      (menuItem) => menuItem.menuId == cartItem.productId,
                  orElse: () => MenuList(
                    menuId: 0,
                    nameMenu: '',
                    image: '',
                    stock: 0,
                    price: 0,
                    category: '',
                    statusMenu: '0',
                    description: '',
                  ), // Default object
                );

                int toppingTotalPrice = 0;

                if (cartItem.selectedToppings != null) {
                  for (var topping in cartItem.selectedToppings!) {
                    toppingTotalPrice += topping.priceTopping;
                  }
                }
                final totalItemPrice = (cartItem.price + toppingTotalPrice) * cartItem.quantity.value;
                return Container(

                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(()=>Container(
                          width: screenWidth / 3.4,
                          height: screenWidth / 3.4,
                          foregroundDecoration: (menu.stock! > 1 &&
                              scheduleController.jadwalElement[0].is_open &&
                              menu.statusMenu != '0' &&
                              (cartItem.selectedVarian == null || popUpController.varianList.any((variantItem) => variantItem.varianID == cartItem.selectedVarian?.varianID && variantItem.statusVarian == '1')) &&
                              (cartItem.selectedToppings == null || cartItem.selectedToppings!.isEmpty || cartItem.selectedToppings!.every((element) => element.statusTopping == '1'))
                          ) ? null
                              : const BoxDecoration(
                            color: Colors.grey,
                            backgroundBlendMode: BlendMode.saturation,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              cartItem.productImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),
                      Expanded(
                        child:
                        Column(
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
                                          final product = controller.menuController.menuWithDisable.firstWhere((element) => element.menuId == cartItem.productId,orElse: () => MenuList(
                                            menuId: 0,
                                            nameMenu: '',
                                            image: '',
                                            stock: 0,
                                            price: 0,
                                            category: '',
                                            statusMenu: '0',
                                            description: '',
                                          ));
                                          popUpController.showCustomModalForItem(product, context, cartItem.quantity.value, cartid: cartItem.cartId?.value ?? 0);
                                          },
                                        child: const Icon(Icons.edit,size: 30,color: Colors.orange,)),
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
                              child: Text(cartItem.selectedVarian?.nameVarian ?? ""),
                            ),
                            Visibility(
                              visible: cartItem.selectedToppings != null && cartItem.selectedToppings!.isNotEmpty,
                              child: Container(

                                decoration: const BoxDecoration(
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
                                          style: const TextStyle(overflow: TextOverflow.ellipsis),
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
                                CounterWidget2(index: cartItem.cartId?.value ?? 0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Obx(() {
                return Column(
                  children: [

                    const SizedBox(height: 10),
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
                              const SizedBox(
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
                    const SizedBox(height: 10),
                    const Divider(),
                    //Voucher Price
                    const SizedBox(height: 10),
                  ],
                );
              }),
              Obx((){
                RxBool hasDisableMenu = controller.cartItems2.any((cartItem) {
                  final menu = controller.menuController.menuElement.firstWhere((menuItem) => menuItem.menuId == cartItem.productId, orElse: () => MenuList(menuId: 0, statusMenu: '0', image: '', nameMenu: '', price: 0, category: '', description: ''));return menu.statusMenu! != '1';}).obs;
                RxBool hasDisableVarian = controller.cartItems2.any((cartItem) {
                  if (cartItem.selectedVarian == null) return false; // No variant selected, so it cannot be disabled
                  final varian = popUpController.varianList.firstWhere(
                        (variantItem) => variantItem.varianID == cartItem.selectedVarian?.varianID,
                    orElse: () => VarianList(varianID: 0, nameVarian: '', statusVarian: "0", category: '', stockVarian: ''), // Return an enabled state by default
                  );
                  return varian.statusVarian != '1' || varian == null; // Return true if variant is disabled
                }).obs;

                RxBool hasDisableTopping = controller.cartItems2.any((cartItem) {
                  return cartItem.selectedToppings?.any((selectedTopping) {
                    final matchingTopping = popUpController.toppingList.firstWhere(
                          (toppingItem) => toppingItem.toppingID == selectedTopping.toppingID,
                      orElse: () => ToppingList(menus: [],nameTopping: '',priceTopping: 0,toppingID:-1 ,statusTopping: "0",stockTopping: "0"), // Return a default Topping object
                    );

                    // Return true if a matching topping is found and its status is not '1'
                    return matchingTopping.statusTopping != '1';
                  }) ?? false; // Return false if selectedToppings is null
                }).obs;


                RxBool hasLowStock = controller.cartItems2.any((cartItem) {
                  final menu = controller.menuController.menuElement
                      .firstWhere((menuItem) => menuItem.menuId == cartItem.productId, orElse: () => MenuList(menuId: 0, statusMenu: '0', image: '', nameMenu: '', price: 0, category: '', stock: 0,description: ''));
                  return menu.stock! > 1;
                }).obs;
                 return InkWell(
                   onTap: () async {
                     controller.isLoadingButton.value = true;
                     await controller.menuController.fetchProduct();
                      await popUpController.fetchTopping();
                      await popUpController.fetchVarian();
                     bool isScheduleFetched = await controller.fetchSchedule();
                     if (isScheduleFetched) {
                       if (scheduleController.jadwalElement[0].is_open == false) {
                         Get.snackbar('Pesan', 'Maaf, Toko saat ini sedang tutup. Silahkan coba lagi nanti.', colorText: Colors.black);
                       } else {
                         if (hasDisableMenu.value) {
                           Get.snackbar('Pesan', 'Keranjangmu memiliki menu yang sedang dinonaktifkan.');
                         } else {
                           if(hasDisableVarian.value){
                             Get.snackbar('Pesan', 'Keranjangmu memiliki varian yang sedang dinonaktifkan.');
                           }else if(hasDisableTopping.value){
                             Get.snackbar('Pesan', 'Keranjangmu memiliki topping yang sedang dinonaktifkan.');
                           }else if (hasLowStock.value) {
                             Get.toNamed(Routes.PEMBAYARAN_PAGE);
                           } else {
                             Get.snackbar('Pesan', 'Keranjangmu memiliki menu yang stoknya habis.');
                           }
                         }
                       }
                     } else {
                       Get.snackbar('Pesan', 'Gagal mengambil jadwal, silahkan coba lagi.');
                     }
                   },
                   child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.all(10),
                    child: controller.isLoadingButton.value
                        ? const Center(
                      child: SizedBox(
                        width: 20, // Adjust the width to your preference
                        height: 20, // Adjust the height to your preference
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3, // Adjust the stroke width if needed
                        ),
                      ),
                    ): Text(
                      "Bayar",
                      style: whitevoucherTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
